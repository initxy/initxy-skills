# UI Prototype

在单一路由上生成多个明显不同 UI 变体，通过底部浮动条切换。用户在浏览器里比较，选一个或组合多个，然后丢弃其余。

如果问题是逻辑 / 状态，不是外观，用 [LOGIC.md](LOGIC.md)。

## 适用场景

- “这个页面应该长什么样？”
- “先看几个 dashboard 选项。”
- “给设置页试另一种布局。”
- 用户原本会在脑中比较多个模糊 mockup。

## 两种形状：优先 A

UI 原型最好贴着真实 app：真实 header、sidebar、数据、密度。孤立的 throwaway route 很容易看起来都不错。只要有合理宿主页面，优先 A。

### A. 调整现有页面（默认）

路由已存在。变体在同一路由渲染，由 `?variant=` 控制。保留数据获取、params、auth，只替换渲染子树。

新 section / card / step 如果自然属于现有页面，也按 A，嵌入宿主页。

### B. 新页面（最后手段）

仅当原型对象没有合理宿主页时创建 throwaway route，例如全新顶层 surface。遵循项目路由约定，路径或文件名包含 `prototype`。

使用同样的 `?variant=` 模式。

## 流程

### 1. 写清问题并确定数量

默认 3 个变体，最多 5 个。

在原型位置或顶部注释写一行：

> “Three variants of the settings page, switchable via `?variant=`, on the existing `/settings` route.”

### 2. 生成明显不同的变体

每个变体必须符合：

- 页面目的与可用数据。
- 项目组件库 / 样式系统。
- 明确导出组件名：`VariantA`、`VariantB`、`VariantC`。

变体要结构不同：布局、信息层级、主要操作不同。只改颜色或文案不算。

### 3. 串起来

创建单个 switcher：

```tsx
const variant = searchParams.get("variant") ?? "A";
return (
  <>
    {variant === "A" && <VariantA {...data} />}
    {variant === "B" && <VariantB {...data} />}
    {variant === "C" && <VariantC {...data} />}
    <PrototypeSwitcher variants={["A", "B", "C"]} current={variant} />
  </>
);
```

A：数据获取留在 switcher 上方，只切换渲染。

B：`/prototype/<name>` throwaway route 挂载同样 switcher。

### 4. 底部浮动切换条

固定在屏幕底部中间，包含：

- 左箭头：切到上一个，循环。
- 当前变体 label：如 `B - Sidebar layout`。
- 右箭头：切到下一个，循环。

行为：

- 点击箭头更新 URL search param。
- 键盘左右箭头也可切换；焦点在 input、textarea、contenteditable 时不拦截。
- 外观明显区别于页面本身。
- 生产环境隐藏，用 `NODE_ENV !== "production"` 或等价条件。

把 switcher 放在项目共享 UI 合理位置。

### 5. 交付

给 URL 和 `?variant=` keys。用户反馈通常会是“要 B 的 header 加 C 的 sidebar”，这就是答案。

### 6. 捕获答案并清理

选出胜者后，记录选择和理由。然后：

- A：删除失败变体和 switcher，把胜者折进现有页面。
- B：把胜者提升为真实 route，删除 throwaway route 和 switcher。

不要留下变体组件或 switcher。

## 反模式

- 只改颜色或文案。
- 变体共享过多布局。
- 接真实 mutation；原型应读多写少，必要时用 stub。
- 直接把 prototype 代码发生产；折入真实代码时要重新按生产标准写。
