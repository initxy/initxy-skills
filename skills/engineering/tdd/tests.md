# 好测试与坏测试

## 好测试

集成风格：通过真实接口测试，不 mock 内部部件。

```typescript
test("user can checkout with valid cart", async () => {
  const cart = createCart();
  cart.add(product);
  const result = await checkout(cart, paymentMethod);
  expect(result.status).toBe("confirmed");
});
```

特征：

- 测调用者关心的行为。
- 只用公开 API。
- 能承受内部重构。
- 描述 WHAT，不描述 HOW。
- 一个测试验证一个逻辑行为。

## 坏测试

实现细节测试：耦合内部结构。

```typescript
test("checkout calls paymentService.process", async () => {
  const mockPayment = jest.mock(paymentService);
  await checkout(cart, payment);
  expect(mockPayment.process).toHaveBeenCalledWith(cart.total);
});
```

危险信号：

- mock 内部协作者。
- 测私有方法。
- 断言调用次数或顺序。
- 行为没变，重构导致测试失败。
- 测试名描述 HOW。
- 绕过接口验证。

```typescript
// 差：绕过接口
test("createUser saves to database", async () => {
  await createUser({ name: "Alice" });
  const row = await db.query("SELECT * FROM users WHERE name = ?", ["Alice"]);
  expect(row).toBeDefined();
});

// 好：通过接口验证
test("createUser makes user retrievable", async () => {
  const user = await createUser({ name: "Alice" });
  const retrieved = await getUser(user.id);
  expect(retrieved.name).toBe("Alice");
});
```
