# HTML Report

当候选关系复杂时，输出单文件 HTML 报告到临时目录，不写进 repo。

## 文件

路径：

```text
${TMPDIR:-/tmp}/architecture-review-<timestamp>.html
```

macOS 可用：

```bash
open "$path"
```

## 结构

```html
<!doctype html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8" />
    <title>Architecture review - {{repo}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
  </head>
  <body class="bg-stone-50 text-slate-900">
    <main class="max-w-5xl mx-auto px-6 py-10 space-y-10">
      <header>repo / date / legend</header>
      <section id="candidates">candidate cards</section>
      <section id="top-recommendation">top recommendation</section>
    </main>
  </body>
</html>
```

## 每个候选卡片

- 标题：命名 deepening。
- Badge：`Strong` / `Worth exploring` / `Speculative`。
- 文件：monospace 列表。
- Before / After：并排图。
- Problem：一句话。
- Solution：一句话。
- Wins：≤5 条短 bullet，必须写局部性 / 杠杆 / 接口 / 测试。
- ADR conflict：如有，用 amber callout。

## 图形选择

- 调用关系：Mermaid `flowchart`。
- 顺序交互：Mermaid `sequenceDiagram`。
- 浅模块堆叠：HTML 横向层叠图。
- 接口过宽：两个矩形对比“接口面积 / 实现面积”。
- deepening：一个粗边框深模块，内部细节淡化。

## 文字风格

短。图承担主要解释。

必须使用：模块、接口、实现、seam、adapter、深模块、浅模块、局部性、杠杆。

不要写：

- “代码更优雅”
- “更清晰”
- “更好维护”

改写成：

- “局部性：规则集中到一个模块”
- “杠杆：一个接口覆盖 N 个调用方”
- “测试：通过 public interface 锁行为”
