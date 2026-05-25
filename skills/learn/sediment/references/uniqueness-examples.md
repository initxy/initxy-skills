# 唯一性示例

判断是否值得写个人沉淀时读取本文件。

## 应该存

- 「我做数据密集型个人项目默认选 Postgres，因为 Mongo 的 schema 漂移在 X/Y/Z 三个项目里都让我迁移痛苦。」
- 「我紧张时会过早抽象 React hook；等第三次重复再抽。」
- 「在我的项目里，没有幂等键的重试已经两次制造重复业务记录。」

## 不该存

- 「Postgres 支持事务。」
- 「TDD 是 red-green-refactor。」
- 「重试要用 exponential backoff。」
- 「React component 应该小。」

## 边界情况

只有包含你自己的证据、失败案例或非显然边界时才存。
