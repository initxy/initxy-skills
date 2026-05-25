# Language

本 skill 的共享词汇。必须使用这些词，不要替换成 component、service、API、boundary。

## Terms

**Module**
任何有 interface 和 implementation 的东西。尺度无关：函数、class、package、跨层切片都算。
_Avoid_: unit, component, service.

**Interface**
调用方正确使用 module 必须知道的一切：类型签名、invariant、调用顺序、错误模式、配置、性能特征。
_Avoid_: API, signature.

**Implementation**
module 内部代码。与 Adapter 区分：讨论 seam 时说 adapter，否则说 implementation。

**Depth**
interface 的杠杆率：调用方每学习一点 interface 能触发多少行为。大量行为藏在小 interface 后就是 deep；interface 几乎和 implementation 一样复杂就是 shallow。

**Seam**
来自 Michael Feathers：无需编辑当前位置就能改变行为的位置。也就是 module interface 所在处。
_Avoid_: boundary.

**Adapter**
在 seam 处满足 interface 的具体东西。描述角色，不描述内部材料。

**Leverage**
调用方从 depth 获得的收益：每单位 interface 提供更多能力。

**Locality**
维护者从 depth 获得的收益：变化、bug、知识和验证集中在一处。

## Principles

- Depth 是 interface 的属性，不是 implementation 的行数。deep module 内部仍可由小的、可替换的部件组成，只是它们不属于外部 interface。
- 删除测试：删掉 module 后，如果复杂度消失，它只是转发；如果复杂度散回 N 个调用方，它有价值。
- interface 是测试表面。测试若需要越过 interface，module 形状可能错了。
- 一个 adapter 是假设 seam；两个 adapter 才是真 seam。

## Relationships

- Module 有一个 Interface。
- Depth 是 Module 相对 Interface 的属性。
- Seam 是 Module 的 Interface 所在位置。
- Adapter 位于 Seam 并满足 Interface。
- Depth 为调用方产生 Leverage，为维护者产生 Locality。

## Rejected framings

- 用 implementation 行数 / interface 行数衡量 depth：会奖励填充实现。
- 把 Interface 等同于 TypeScript `interface` 或 public methods：太窄。
- 使用 Boundary：DDD 中已被 bounded context 重载。说 Seam 或 Interface。
