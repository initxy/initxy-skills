# CONTEXT.md 格式

## 结构

```md
# {上下文名称}

{一两句话说明这个上下文是什么、为什么存在。}

## Language

**Order**:
{一两句话定义该术语}
_Avoid_: Purchase, transaction

**Invoice**:
交付后发送给客户的付款请求。
_Avoid_: Bill, payment request

**Customer**:
下单的个人或组织。
_Avoid_: Client, buyer, account
```

## 规则

- 要有立场。多个词表示同一概念时，选一个标准词，其余放进 `_Avoid_`。
- 明确标出冲突。术语被混用时，在 `Flagged ambiguities` 中写清解决方案。
- 定义要短。一两句话，说明它是什么，不说明它做什么。
- 写关系。用粗体术语表达明显基数关系。
- 只放本项目上下文特有概念。超时、错误类型、工具函数这类通用编程概念不放。
- 自然成组时用小标题；没有必要时保持扁平。
- 写一段示例对话，展示术语如何自然互动，并澄清相近概念边界。

## 单上下文与多上下文

单上下文：根目录一个 `CONTEXT.md`。

多上下文：根目录 `CONTEXT-MAP.md` 指向各上下文：

```md
# Context Map

## Contexts

- [Ordering](./src/ordering/CONTEXT.md) — 接收并跟踪客户订单
- [Billing](./src/billing/CONTEXT.md) — 生成发票并处理支付
- [Fulfillment](./src/fulfillment/CONTEXT.md) — 管理拣货与发货

## Relationships

- **Ordering -> Fulfillment**: Ordering 发出 `OrderPlaced` 事件，Fulfillment 消费它开始拣货
- **Fulfillment -> Billing**: Fulfillment 发出 `ShipmentDispatched` 事件，Billing 消费它生成发票
- **Ordering <-> Billing**: 共享 `CustomerId` 和 `Money` 类型
```

推断规则：

- 有 `CONTEXT-MAP.md` 就读它找上下文。
- 只有根 `CONTEXT.md` 就按单上下文处理。
- 都没有时，在第一个术语明确后懒创建根 `CONTEXT.md`。
- 多上下文且无法判断当前主题属于哪里时，问用户。
