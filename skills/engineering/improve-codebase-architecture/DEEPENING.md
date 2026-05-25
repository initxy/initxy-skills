# Deepening

在给定依赖关系下，安全地加深一组浅模块。术语沿用 [LANGUAGE.md](LANGUAGE.md)：module、interface、seam、adapter。

## 依赖分类

### 1. In-process

纯计算、内存状态、无 I/O。总是可加深：合并 module，通过新 interface 直接测试。不需要 adapter。

### 2. Local-substitutable

有本地测试替身的依赖，例如 PGLite 替 Postgres、内存文件系统。存在替身就可加深；测试时用替身跑。seam 是内部的，不暴露到外部 interface。

### 3. Remote but owned：Ports & Adapters

你拥有的跨网络服务：微服务、内部 API。seam 处定义 port；深模块拥有逻辑，transport 以 adapter 注入。测试用内存 adapter，生产用 HTTP / gRPC / queue adapter。

推荐表述：

> 在 seam 处定义 port，生产实现 HTTP adapter，测试实现 in-memory adapter，让逻辑集中在一个 deep module 中。

### 4. True external：Mock

第三方服务，例如 Stripe、Twilio。深模块把外部依赖作为注入 port，测试提供 mock adapter。

## Seam discipline

- 一个 adapter 是假设 seam；两个 adapter 才是真 seam。没有至少两个合理 adapter，不要引入 port。
- deep module 可以有内部 seam，但不要因为测试使用它就暴露到外部 interface。

## 测试策略：替换，不叠加

- 新的 deep module interface 测试存在后，旧浅模块单测通常是浪费，应删除。
- 新测试写在 deep module interface 上。
- 测试断言可观察结果，不断言内部状态。
- 测试应能承受内部重构。
