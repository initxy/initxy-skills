# Full RFC Template

> **用途**：`rfc` skill 的完整 RFC 文档模板。每次写新 RFC 时按此结构填写。
>
> **关于下方的示例值**（如 `Hono`、`BullMQ`、`db.t3.medium`、`$0.068/h` 等）：
> 这些**仅为示例**，演示填完后长什么样。**不是必须沿用的栈**。
> 你的默认栈应在 `../SKILL.md` 的「默认栈」小节填写并保持稳定；
> 偏离默认栈时在「技术栈」小节标明理由。
>
> **使用方式**：复制下方整段 markdown 到 `docs/rfc/<YYYY-MM-DD>-<slug>.md`，按字段填写。

---

```markdown
# RFC-<编号>: <标题>

**作者**：<姓名>
**日期**：<YYYY-MM-DD>
**状态**：`draft` | `review` | `accepted` | `superseded`
**相关 ADR**：[ADR-001](../adr/2026-01-01-xxx.md)

---

## 摘要

<!-- 3-5 句话：做什么 / 为什么 / 影响范围 / 关键约束。决策摘要，不是背景介绍。 -->

## 目标

<!-- 可观察结果，用户或系统可测量。 -->
- [ ] <目标 1，包含验收条件>
- [ ] <目标 2>

## 非目标

<!-- 明确说不做什么，防止范围蔓延。 -->
- <不做 1>

## 上下文与动机

<!-- 当前状态、痛点、为什么是现在做、相关历史决策引用。 -->

## 技术栈

| 层 | 选择 | 是否偏离默认栈 | 偏离理由 |
|---|---|---|---|
| Runtime | | | |
| Web 框架 | | | |
| 主存储 | | | |
| 队列 | | | |
| 缓存 | | | |
| 可观测性 | | | |
| 部署 | | | |

## 模块清单

| 模块 | 职责 | 对外接口 | 状态 |
|---|---|---|---|
| <模块名> | <一句话职责> | <接口摘要> | 新建 / 改动 / 不变 |

## API 契约

<!-- 每个对外接口单独小节。内部模块间调用也要列。 -->

### <接口名>

**端点**：`POST /api/v1/xxx`
**幂等性**：幂等（客户端生成 idempotency-key）/ 非幂等

**请求**：
\`\`\`json
{
  "field": "string // 说明"
}
\`\`\`

**响应 2xx**：
\`\`\`json
{}
\`\`\`

**错误码**：
| 状态码 | 错误类型 | 触发条件 |
|---|---|---|
| 400 | INVALID_INPUT | |
| 409 | CONFLICT | |
| 503 | DEPENDENCY_UNAVAILABLE | |

## 数据模型

### <表/集合名>

| 字段 | 类型 | 约束 | 说明 |
|---|---|---|---|
| id | UUID | PK, NOT NULL | |

**索引**：
- `idx_xxx_yyy ON xxx(yyy)` — 用于查询场景 Z

**迁移策略**：<!-- 加列用 online DDL / 数据回填脚本 / 双写过渡期 -->

## 数据流

<!-- 端到端，从用户请求到数据落地。可用 ASCII 序列图或编号步骤。 -->

\`\`\`
Client → API Gateway → Service A → Queue → Worker B → DB
                                 ↘ Cache
\`\`\`

1. Client 发送请求到 API Gateway（含 auth token）。
2. Service A 校验、写入 Queue（幂等 key = request_id）。
3. Worker B 消费消息，写 DB，更新 Cache。
4. 返回 202 Accepted，Client 轮询状态端点。

## 状态机

<!-- 如有有状态实体（订单、任务、工单），画出状态转移。 -->

\`\`\`
[PENDING] --submit--> [PROCESSING] --done--> [COMPLETED]
                           |
                         fail
                           ↓
                       [FAILED] --retry--> [PROCESSING]
\`\`\`

| 状态 | 合法转移 | 触发动作 |
|---|---|---|
| PENDING | → PROCESSING | submit 事件 |

## NFR（非功能需求）

<!-- 每条必须有数字 + 测量方式，不接受"快"、"高可用"等形容词。 -->

| 指标 | 目标值 | 测量方式 |
|---|---|---|
| P95 响应时间 | < 200ms | k6 压测，100 并发，5 分钟 |
| P99 响应时间 | < 500ms | 同上 |
| 吞吐 | 1000 rps（峰值 3000 rps） | 压测 + 生产 metric |
| 可用性 SLA | 99.9%（月度） | Uptime Robot + PagerDuty |
| 数据一致性 | 最终一致，延迟上限 < 5s | 集成测试验证 |
| 容量上限 | 1000 万行 / 100GB，3 年内不触顶 | 容量规划模型 |
| 冷启动时间 | < 3s | 部署流水线测量 |

## 失败模式与降级

<!-- 每个外部依赖必须列出 fail 时的行为。 -->

| 依赖 | 失败场景 | 系统行为 | 恢复方式 |
|---|---|---|---|
| <主存储> | 连接超时 | 返回 503，熔断 30s | 自动重连，告警 |
| <缓存> | 不可用 | 降级直读 DB，限流 50% | 自动恢复 |
| <第三方 API X> | 超时 / 5xx | 写入 DLQ，异步重试 3 次 | 指数退避，最终 FAILED |
| <队列> | 后端宕机 | 拒绝新请求（fail fast），告警 | 恢复后手动 replay DLQ |

## 可观测性

### Logs

| 位置 | 级别 | 必填字段 | 示例 |
|---|---|---|---|
| Service A 入口 | INFO | trace_id, user_id, endpoint | `{"event":"request","trace_id":"..."}` |
| Worker B 失败 | ERROR | trace_id, job_id, error_code, retry_count | |

### Metrics

| 指标名 | 类型 | 标签 | 含义 |
|---|---|---|---|
| `http_request_duration_ms` | Histogram | endpoint, status_code | 请求延迟分布 |
| `queue_job_processed_total` | Counter | queue, status | 消费成功/失败计数 |
| `cache_hit_ratio` | Gauge | cache_name | 缓存命中率 |

### Traces

关键 span：
- `service_a.handle_request`（含 user_id tag）
- `worker_b.process_job`（含 job_id, attempt_number tag）
- `db.query`（含 table, operation tag）

## 安全模型

| 维度 | 设计 |
|---|---|
| 认证 | JWT（RS256），有效期 1h，refresh token 7 天 |
| 授权 | RBAC：admin / operator / viewer；接口级权限矩阵见附录 |
| 数据敏感度 | PII 字段（email, phone）静态加密（AES-256），传输 TLS 1.3 |
| 威胁场景 1 | 重放攻击 → idempotency-key + nonce 校验 |
| 威胁场景 2 | 越权读取 → 行级 RLS（如 PostgreSQL Row Level Security） |
| 威胁场景 3 | 依赖注入 → 参数化查询，禁止字符串拼接 SQL |
| 审计日志 | 所有写操作记录 operator_id + before/after snapshot |

## 成本估算

| 项目 | 单价 | 用量 | 月成本 |
|---|---|---|---|
| <DB 实例> | $X/h | 720h | ~$Y |
| <缓存实例> | $X/h | 720h | ~$Y |
| <K8s 节点 × N> | $X/h | 720h × N | ~$Y |
| <第三方 API> | $X/call | N 次/月 | ~$Y |
| **合计** | | | **~$Z/月** |

> 人力成本：预估开发 N 人周，维护 M 人/月。

## 风险与 Trade-off

| 风险 | 概率 | 影响 | 缓解措施 |
|---|---|---|---|
| <第三方 API 限流> | 中 | 高 | 本地缓存 + 指数退避 + DLQ |
| <DB 读写热点> | 低 | 高 | 分区键设计 + 读副本 |
| <团队对某技术经验不足> | 高 | 中 | 选低学习成本替代 |

**主要 Trade-off**：选最终一致 vs 强一致。选最终一致换写入延迟降低 60%，代价是读取方需容忍 5s 内陈旧数据。

## 开放决策

- [ ] **OD-1**：分页策略用 cursor-based 还是 offset？影响：大数据集性能差异 10× → 待 `decide`。
- [ ] **OD-2**：告警阈值具体数值待压测后确定。

## 回滚预案

1. **Feature flag 关闭**：`ENABLE_NEW_FLOW=false` → 流量回旧路径，零停机。
2. **版本回退**：`<deploy tool> rollback <release> <revision>`，预计 < 2 分钟。
3. **数据迁移回滚**：执行 `migrations/rollback_YYYYMMDD.sql`，幂等，可重复执行。
4. **兼容期**：新旧 API 同时服务 N 周，客户端灰度迁移；旧端点加 `Deprecation` 响应头。
5. **验证回滚成功**：error rate < 0.1%，P95 < 200ms，持续 5 分钟。

## 里程碑

| 阶段 | 内容 | 目标日期 |
|---|---|---|
| M0 | RFC 定稿（通过 grill） | <日期> |
| M1 | 核心数据模型 + API skeleton | <日期> |
| M2 | Worker + 集成测试覆盖关键路径 | <日期> |
| M3 | NFR 压测达标，可观测性接入 | <日期> |
| M4 | 灰度发布 10% 流量，监控 48h | <日期> |
| M5 | 全量发布，旧系统下线 | <日期> |

## 待 grill 的部分

<!-- 作者自己也不确定的假设，提示 grill 重点攻击。 -->
- <假设 1，未经实测，依赖供应商 SLA 文档>
- <假设 2，需要压测验证>
- <假设 3，端到端未测>
```
