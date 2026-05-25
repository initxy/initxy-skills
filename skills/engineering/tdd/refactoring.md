# Refactor Candidates

TDD 循环后检查：

- 重复 -> 提取函数 / class。
- 长方法 -> 拆私有 helper，但测试仍走公开接口。
- 浅模块 -> 合并或加深。
- Feature envy -> 把逻辑移到数据所在处。
- Primitive obsession -> 引入 value object。
- 新代码暴露出的旧代码问题。
