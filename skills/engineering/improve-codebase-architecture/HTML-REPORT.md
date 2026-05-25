# HTML Report Format

架构 review 输出为系统临时目录中的单个自包含 HTML。Tailwind 和 Mermaid 走 CDN。Mermaid 适合图状依赖；手写 div / inline SVG 适合更有编辑感的视觉。两者混用，不要全靠 Mermaid。

## Scaffold

```html
<!doctype html>
<html lang="zh-CN">
  <head>
    <meta charset="utf-8" />
    <title>Architecture review — {{repo name}}</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script type="module">
      import mermaid from "https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs";
      mermaid.initialize({ startOnLoad: true, theme: "neutral", securityLevel: "loose" });
    </script>
    <style>
      .seam { stroke-dasharray: 4 4; }
      .leak { stroke: #dc2626; }
      .deep { background: linear-gradient(135deg, #0f172a, #1e293b); }
    </style>
  </head>
  <body class="bg-stone-50 text-slate-900 font-sans">
    <main class="max-w-5xl mx-auto px-6 py-12 space-y-12">
      <header>...</header>
      <section id="candidates" class="space-y-10">...</section>
      <section id="top-recommendation">...</section>
    </main>
  </body>
</html>
```

## Header

仓库名、日期、紧凑图例：实线框 = module；虚线 = seam；红箭头 = leakage；粗深色框 = deep module。不要写介绍段，直接进入候选项。

## Candidate card

图承担主要信息量；文字少而清晰，并使用 [LANGUAGE.md](LANGUAGE.md) 词汇。

每个 `<article>`：

- Title：短，命名 deepening。
- Badge row：`Strong` / `Worth exploring` / `Speculative`，再加依赖类型标签。
- Files：monospace 列表。
- Before / After diagram：核心，两列并排。
- Problem：一句话说明痛点。
- Solution：一句话说明变化。
- Wins：bullet，每条不超过 6 个词。
- ADR callout：如果适用，一行 amber 提示。

如果图需要长段解释才能懂，重画图。

## Diagram patterns

- Mermaid graph：展示调用、依赖、序列。
- 手写 boxes-and-arrows：Mermaid 布局不合适时使用。
- Cross-section：展示多层浅薄调用。
- Mass diagram：展示 interface 与 implementation 体量接近。
- Call-graph collapse：前后对比一棵调用树如何折叠进一个 module。

## Style

- 编辑感，不做企业 dashboard。
- 留白足；可用 serif 标题。
- 色彩克制：一个强调色 + 红色 leakage + amber warning。
- 图高约 320px，before / after 不应难以比较。
- module 标签用 `text-xs uppercase tracking-wider`。
- 只允许 Tailwind CDN 与 Mermaid ESM 脚本，无 app 交互代码。

## Top recommendation

一个大卡片：候选名、一句理由、链接到候选 card。

## Tone

简洁英文或中文都可以，但架构名词必须来自 [LANGUAGE.md](LANGUAGE.md)。

固定使用：module, interface, implementation, depth, deep, shallow, seam, adapter, leverage, locality。

不要替换：component、service、API、boundary。

好句式：

- "Order intake module is shallow — interface nearly matches the implementation."
- "Pricing leaks across the seam."
- "Deepen: one interface, one place to test."
- "Two adapters justify the seam: HTTP in prod, in-memory in tests."

Wins bullet 要用词汇表表达收益：`locality: bugs concentrate in one module`、`leverage: one interface, N call sites`。
