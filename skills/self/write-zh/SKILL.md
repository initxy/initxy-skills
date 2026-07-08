---
name: write-zh
description: Guides the user through writing a Chinese document section by section — clarifying intent, co-defining an outline, drafting each part, embedding diagrams, and enforcing a personal first-principles voice — to produce diagram-rich prose free of AI-flavored writing. Use when the user wants to write, draft, or co-author a Chinese article, blog post, essay, design doc, README, or long-form document with guidance instead of one-shot generation.
---

# 引导式中文写作

## 核心原则

好文档不是把要点填进模板,而是把一个问题想透之后,自然长出来的结构。

所以这个 skill 的动作是「引导用户想透 + 帮他落笔」,不是「替他生成一篇」。一句话喂进去吐出整篇,正是 AI 味的根源。

## 子文件

正文只放流程和默认风格。三件事的细节拆在 `references/` 里,在对应环节去读:

- **写作技巧**(`references/techniques.md`):人味从哪来。起草任何一节前先读。
- **去 AI 味**(`references/de-ai.md`):完整清单和正反例。起草时对照,收尾时逐条扫。
- **语言风格**(`references/styles.md`):五种可切换的风格画像。用户想换风格、或拿不准用哪种声音时读。

## 何时用

- 主打:有想法密度的技术/思考长文、博客、随笔。也能写设计文档、README、提案。
- 两个入口:
  - **从零写**:走下面完整三阶段。
  - **已有草稿**:跳过阶段一,直接进阶段三(去 AI 味 + 风格 + 配图),需要时再回头补结构。

## 工作方式

逐节推进,中等颗粒度。不一次代写整篇,也不做「每节抛一堆选项让用户勾选」的重流程。

### 阶段一 · 摸意图、第一性拆解、共定大纲

先问清楚,一次只问一个,等回答再问下一个:

- 写给谁?他们读完应该改变什么:知道什么、相信什么、会做什么?
- 手里有哪些真材料:数据、亲历、代码、踩过的坑、明确的观点?
- 有没有目标平台、篇幅、格式上的约束?用哪种风格(默认底色,还是 `styles.md` 里某一种)?

再做第一性拆解:把题目拆到不能再拆的基本事实和硬约束,从这些往上推,而不是先套一个现成结论或别人的框架。

共定大纲后,落成 `.md` 骨架,每个小节一个标题加占位,作为逐节填充的脚手架。

### 阶段二 · 逐节推进

从最不确定的小节先写,通常是核心论点;开头和概述留到最后。对每个小节:

1. 先问这节的核心要点和素材,用户可以简答或丢一段过来。
2. 起草这节。起草前先把 `references/techniques.md` 过一遍,落笔就用上;同时套用下面「风格」「配图」的规则,并对照 `references/de-ai.md` 不犯常见 tell。
3. 用户提修改,用 Edit 局部更新文件,不重印全文。

### 阶段三 · 通读收尾

- 用 `references/de-ai.md` 的速查清单整篇扫一遍。
- 查风格是否前后统一(同一篇别一段科普一段硬核地跳)。
- 查图够不够、贴不贴、标签是否具体。
- 收尾要轻:不写「总结 / 结语 / 写在最后 / 希望对你有帮助」式套话。

## 风格

默认底色:两条主线,主次分明。想要别的声音(清淡科普、老练实战、口语个人、严谨工程……),去 `references/styles.md` 选一种为主。

### 第一性原理(主)

- 论证靠事实和约束推导,不靠类比、不靠「业界一般认为」「大家都知道」推进。
- 遇到现成结论先问「凭什么」,把它还原成可检验的前提。
- 和传统冲突时,从头推优先。诉诸先贤不能替代论证。

### 传统文化(淡淡点缀)

- 偶尔一句契合的诗词、古文、典故,只在它真能点睛时落,绝不为引而引。
- 宁少勿滥:整篇以现代白话为底,一两处足矣。堆古文就是失败。

### 语气

像一个已经想清楚的人,平静地讲给同行听。不端着,不煽情,不喊口号。

## 配图

每个核心概念、流程、对比、结构,配一张图。能用图说清的,就别写一大段。默认用 mermaid。

思维模式对应图类型:

| 想表达 | 用 |
|---|---|
| 拆解 / 概念结构 | mermaid mindmap 或 graph |
| 流程 / 时序 | flowchart / sequenceDiagram |
| 分类 / 对比 | markdown 表格 或 quadrantChart |
| 因果 / 依赖 | 有向 graph |
| 第一性推导链 | 自顶向下 graph,从基本事实推到结论 |

约定:

- 图用真实标签,不用「模块 A / 模块 B」这种占位。
- 默认 mermaid 内联,可进 markdown、可版本管理、好改。
- 目标平台不渲染 mermaid(比如公众号),提示用户把图导出成图片再贴。
- 要做精致的演示级架构图,交给 `architecture-diagram` skill,这里不重造。

## 完成标准

也是 `review` 的验收口径:

- 第一性结构成立:核心论点是从事实和约束推出来的,不是套来的。
- `de-ai.md` 速查清单全过,没有残留 tells。
- 核心概念都有图,图贴切、标签具体。
- 风格统一:整篇一种主声音;默认底色则第一性为主、传统点缀不过量。
- 事实可核,数字、引用、代码真实可用。
- 收尾不套话。
