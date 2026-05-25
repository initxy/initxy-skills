---
name: improve-codebase-architecture
description: 基于 CONTEXT.md 的领域语言和 docs/adr/ 的决策，寻找代码库中的 deepening 机会。当用户想改进架构、找重构机会、合并强耦合模块、提升可测试性或 AI 可导航性时使用。
---

# Improve Codebase Architecture

发现架构摩擦，提出 deepening 机会：把浅模块重构成深模块。目标是可测试性和 AI 可导航性。

## 词汇

所有建议都使用这些词，不要漂移到 component、service、API、boundary。完整定义见 [LANGUAGE.md](LANGUAGE.md)。

- **Module**：有 interface 和 implementation 的任何东西。
- **Interface**：调用方正确使用 module 必须知道的一切，不只是类型签名。
- **Implementation**：内部代码。
- **Depth**：interface 的杠杆率；小 interface 后有大量行为。
- **Seam**：interface 所在位置；可在不改当前位置的情况下改变行为。
- **Adapter**：在 seam 处满足 interface 的具体实现。
- **Leverage**：调用方从 depth 获得的收益。
- **Locality**：维护者从 depth 获得的收益，变化、bug、知识集中在一处。

关键原则：

- 删除测试：想象删除 module。复杂度消失 = 它只是转发；复杂度散回 N 个调用方 = 它有价值。
- interface 就是测试表面。
- 一个 adapter 是假设 seam；两个 adapter 才是真 seam。

本 skill 受项目领域模型约束：领域语言帮助命名好 seam，ADR 记录不应反复争论的决策。

## 流程

### 1. 探索

先读项目领域词汇表和相关 ADR。

然后用 Explore 子 agent 或等价方式走读代码。不要套死规则，记录你在哪里感到摩擦：

- 理解一个概念是否需要在许多小 module 间来回跳？
- 哪里是 shallow：interface 几乎和 implementation 一样复杂？
- 是否为了测试抽出了纯函数，但真实 bug 藏在调用方式里，缺少 locality？
- 强耦合 module 是否跨 seam 泄漏？
- 哪些区域未测试，或难以通过当前 interface 测试？

对疑似 shallow 的对象做删除测试。

### 2. 输出 HTML 报告

把自包含 HTML 写到系统临时目录，不写入 repo。临时目录从 `$TMPDIR` 获取，失败用 `/tmp`，Windows 用 `%TEMP%`。文件名：`architecture-review-<timestamp>.html`。

打开给用户：macOS 用 `open <path>`，Linux 用 `xdg-open <path>`，Windows 用 `start <path>`。告诉用户绝对路径。

报告使用 Tailwind CDN；关系图可用 Mermaid CDN，也可以混合手写 CSS/SVG。每个候选项要有 before / after 可视化。

每个候选项包含：

- Files：涉及文件 / module。
- Problem：当前架构造成什么摩擦。
- Solution：要怎么变。
- Benefits：用 locality、leverage、测试改善来说明。
- Before / After diagram：并排展示浅与深。
- Recommendation strength：`Strong` / `Worth exploring` / `Speculative`。

结尾加 Top recommendation：先做哪个、为什么。

领域概念用 `CONTEXT.md` 里的词；架构概念用 [LANGUAGE.md](LANGUAGE.md) 里的词。

如候选项冲突 ADR，只在摩擦足够真实、值得重开 ADR 时标出。

HTML 细节见 [HTML-REPORT.md](HTML-REPORT.md)。

不要先设计 interface。写完报告后问用户：“你想深入哪个候选项？”

### 3. Grilling loop

用户选中候选项后，进入追问会话：约束、依赖、深模块形状、seam 后的内容、哪些测试保留。

决策明确时即时产生副作用：

- 深模块命名使用了 `CONTEXT.md` 没有的概念：把术语写入 `CONTEXT.md`。
- 模糊术语被收紧：立即更新 `CONTEXT.md`。
- 用户用强理由拒绝候选项：只有未来 review 需要避免重复建议时，询问是否记录 ADR。
- 想探索替代 interface：使用 [INTERFACE-DESIGN.md](INTERFACE-DESIGN.md)。
