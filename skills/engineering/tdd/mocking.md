# 何时 Mock

只在系统边界 mock：

- 外部 API：支付、邮件等。
- 数据库：有时可以 mock，但优先 test DB。
- 时间和随机性。
- 文件系统：有时可以 mock。

不要 mock：

- 自己的 class / module。
- 内部协作者。
- 你能控制的东西。

## 为可 mock 性设计

### 1. 依赖注入

```typescript
// 易 mock
function processPayment(order, paymentClient) {
  return paymentClient.charge(order.total);
}

// 难 mock
function processPayment(order) {
  const client = new StripeClient(process.env.STRIPE_KEY);
  return client.charge(order.total);
}
```

### 2. SDK 风格接口优于通用 fetcher

```typescript
// 好：每个函数可独立 mock
const api = {
  getUser: (id) => fetch(`/users/${id}`),
  getOrders: (userId) => fetch(`/users/${userId}/orders`),
  createOrder: (data) => fetch("/orders", { method: "POST", body: data }),
};

// 差：mock 内部需要条件分支
const api = {
  fetch: (endpoint, options) => fetch(endpoint, options),
};
```

SDK 风格的好处：

- 每个 mock 返回一个明确 shape。
- 测试 setup 不需要条件逻辑。
- 更容易看出测试触达哪些 endpoint。
- 每个 endpoint 都有类型约束。
