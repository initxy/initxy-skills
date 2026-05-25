# Domain Docs

工程类 skill 探索代码前如何读取本仓库领域文档。

## 探索前读取

- 根目录 `CONTEXT.md`；或
- 根目录 `CONTEXT-MAP.md`，它指向每个上下文的 `CONTEXT.md`；只读与当前主题相关的。
- `docs/adr/`；多上下文仓库还检查 `src/<context>/docs/adr/`。

这些文件不存在时静默继续。不要把缺失当问题，也不要提前建议创建；生产方 skill（`/grill-with-docs`）会在术语或决策明确时懒创建。

## 文件结构

单上下文：

```text
/
├── CONTEXT.md
├── docs/adr/
└── src/
```

多上下文：

```text
/
├── CONTEXT-MAP.md
├── docs/adr/
└── src/
    ├── ordering/
    │   ├── CONTEXT.md
    │   └── docs/adr/
    └── billing/
        ├── CONTEXT.md
        └── docs/adr/
```

## 使用词汇表

输出中提到领域概念时，使用 `CONTEXT.md` 定义的术语。不要漂移到 `_Avoid_` 中列出的同义词。

如果词汇表没有你需要的概念，要么说明你可能在发明项目不用的语言，要么指出这是 `/grill-with-docs` 需要补的空缺。

## 标出 ADR 冲突

如果你的输出与现有 ADR 冲突，明确指出，而不是静默覆盖：

> _Contradicts ADR-0007 (event-sourced orders) — but worth reopening because..._
