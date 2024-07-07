---
name: analyze-pr-diff-generate-testcase
description: >-
  针对开发提交的 Pull Request，拉取源分支与目标分支完整代码 diff，识别文件、代码行、业务逻辑变更范围；
  区分新增/修改/删除/参数/条件/依赖等改动类型，拆解执行链路与分支逻辑；结合历史参考用例模板，
  生成覆盖改动点的标准化测试用例（CSV / Markdown / XMind），标记高风险模块并补充回归要点，
  用于合并前测试准入校验。只要用户提到「分析 PR 差异」「按 diff 生成测试用例」「PR 测试用例」
  「前后端联动 diff 用例」「导出 xmind/csv/md 用例」等，都应使用本技能。
---

# 分析 Pull Request 差异输出测试用例

## 使用示例

```text
1. 前端单仓：帮我分析前端 PR 差异，源分支 lx/feat-premium-dot-numeric-username、目标分支 premium/release-v260630-normal，参考已有测试用例模板，生成用例输出到/Users/menghuawei/workspace/my-project/gitee-work/02.需求测试/PR测试用例集合
2. 后端单仓：帮我分析后端 PR 差异，源分支 phc/fix/webhook-logs-filter、目标分支 release/v260731-normal-premium，参考已有测试用例模板，生成用例输出到/Users/menghuawei/workspace/my-project/gitee-work/02.需求测试/PR测试用例集合
3. 前后端联动：同步分析前端源分支 phc/feat/numeric-dot-user-path、目标分支 release/v260630-normal-premium，后端源分支 lx/feat-premium-dot-numeric-username、目标分支 premium/release-v260630-normal，联动梳理前后端交互改动点，同时生成 csv/md/xmind 三套测试用例，标注接口联调风险点
4. 附加增强：分析diff后标注高风险改动，额外补充旧功能回归测试点
```

## 一、环境与仓库基础配置

### 1.1 后端服务仓库

- 本地仓库路径：`/Users/menghuawei/workspace/work-project/gitee`
- 切换分支命令：`git checkout 分支名`
- 标准对比 diff 命令：

```shell
cd /Users/menghuawei/workspace/work-project/gitee
git fetch origin
git diff origin/【源分支】 origin/【目标分支】
```

- 示例分支对照
  - 源分支：`origin/feat/premium-admin-audit-log`
  - 目标分支：`origin/premium/release-v260430-geely`

### 1.2 前端 Web 仓库

- 本地仓库路径：`/Users/menghuawei/workspace/work-project/gitee-ent-web`
- 标准对比 diff 命令：

```shell
cd /Users/menghuawei/workspace/work-project/gitee-ent-web
git fetch origin
git diff origin/【源分支】 origin/【目标分支】
```

- 示例分支对照
  - 源分支：`origin/phc/feat/user-login-history`
  - 目标分支：`origin/release/v260430-normal-premium`

### 1.3 测试用例输出存储路径

默认输出目录：`/Users/menghuawei/workspace/my-project/gitee-work/02.需求测试/PR测试用例集合/`

**文件命名规则**（三种格式共用同一主文件名）：

```text
PR用例-{端}-{源分支短名}-yyyyMMdd.{csv|md|xmind}
```

- `{端}`：`前端` / `后端` /  `联动`
- `{源分支短名}`：取源分支名，将 `/` 替换为 `-`；联动场景取**后端源分支**短名（两端功能关键词一致时可改用功能关键词）
- 同分支同日重复分析时：追加时分 `-HHmm`，如 `PR用例-后端-feat-premium-admin-audit-log-20260723-1430.csv`

示例：

| 场景 | 文件名 |
|------|--------|
| 后端单仓 | `PR用例-后端-feat-premium-admin-audit-log-20260723.csv` |
| 前端单仓 | `PR用例-前端-phc-feat-user-login-history-20260723.md` |
| 前后端联动 | `PR用例-联动-feat-add-department-watchdog-config-20260723.xmind` |

分支名过长时，可用功能关键词替代源分支短名：`PR用例-{端}-{功能关键词}-yyyyMMdd.csv`（如 `PR用例-后端-audit-log-20260723.csv`）。

## 二、执行流程

### Step1：信息接收与解析

1. 区分**后端 / 前端 / 前后端联动**，提取源分支、目标分支；同时识别输出格式、输出目录、高风险标记、回归用例和参考样例等可选要求。
2. 拉取完整 diff，覆盖文件清单、增删行、上下文、依赖、SQL、接口定义、前端组件与请求逻辑。
3. 联动场景匹配前端请求与后端实现，核对参数传递、校验规则、返回体映射和异常处理。

### Step2：改动类型分类标记

逐文件、代码块归类并编号；联动场景使用 B-后端、F-前端、BF-联调交互点。分类为：【新增】【逻辑修改】【删除】【参数变动】【分支条件】【依赖变更】【数据存储】【权限/校验】。

### Step3：业务逻辑拆解分析

按“业务模块与调用链路 → 输入约束 → 分支与计算 → 正常/异常输出 → 上下游影响”拆解每个改动点。联动场景贯通：前端页面操作 → 接口请求参数 → 后端接收校验 → 业务处理 → 数据库存储 → 返回数据 → 前端渲染展示。

### Step4：多维度场景用例覆盖设计

每个改动点按实际风险覆盖正向、异常、边界、容错降级和关联回归；BF 联调点还需覆盖传参/校验匹配、返回字段渲染及错误码提示。

**用例必须从用户使用角度描述**：以用户角色和可执行操作为起点，沿真实业务路径写步骤，以用户可观察的页面、提示、状态或数据结果作为预期。优先使用“用户在什么条件下做什么，看到什么结果”的表达；不要把方法调用、代码分支或实现细节直接当作用例，也不要只写“功能正常”。

### Step5：标准化用例结构输出

生成前**必读** `references/` 下示例，严格对齐字段、层级与文风：

- [测试用例导入样例.csv](references/测试用例导入样例.csv)
- [测试用例示例.md](references/测试用例示例.md)
- [测试用例示例.xmind](references/测试用例示例.xmind)（可解压查看内部 `content.json`）

#### CSV（结构化导入测试平台）

表头固定（勿增删列、勿改列名），UTF-8 编码，对齐 [测试用例导入样例.csv](references/测试用例导入样例.csv)：

```text
序号,功能模块*,用例名称*,维护人,用例类型,优先级,前置条件,备注,步骤描述,预期结果
```

- 功能模块*：用 `/` 划分目录层级，最多五级（如 `分支管理/分支创建规范/命名规范校验`）
- 用例名称*：一句话可判定的验证点
- 用例类型：功能测试 / 性能测试 / 接口测试 / 安全相关 / 兼容性测试 / UI测试 / 其他（默认功能测试）
- 优先级：P0 / P1 / P2 / P3 / P4（默认 P0）
- 步骤描述 / 预期结果：多步骤用换行分割，顺序一一对应

#### Markdown 标准排版

对齐 [测试用例示例.md](references/测试用例示例.md)：

1. 首行用引用块写 PR 元信息：`> PR信息：后端源分支… 后端目标分支… / 前端源分支… 前端目标分支… | 生成时间：yyyy-MM-dd`
2. 模块（`## **模块名**`）→ 子模块（`- 子模块名`）→ 验证点（缩进 `- 验证…`）
3. 每个验证点一句话、可执行、可判定，避免「功能正常」类空话

```markdown
> PR信息：后端源分支xxx 后端目标分支xxx / 前端源分支xxx 前端目标分支xxx | 生成时间：yyyy-MM-dd

## **模块名**
- 子模块名
  - 验证正向场景…
  - 验证边界/异常场景…
## **非功能需求**
- 兼容性 / 性能 / 安全性 / 易用性
  - 验证…
```

#### XMind 脑图

结构与 MD 大纲同构：根节点标题建议为 `{功能/主题}-测试用例`（或与主文件名一致的 `PR用例-{端}-{源分支短名}-yyyyMMdd`）→ 一级模块 → 子模块 → 验证点（叶子节点，文案与 MD 一致）。根节点 notes 可写入 PR 元信息（与 MD 首行引用块一致）。

格式为 XMind Zen（ZIP 包，含 `content.json` / `metadata.json` / `manifest.json`），用 Python `zipfile` 写入，节点树对应 `rootTopic.children.attached`。生成后确认可用 XMind 打开。对齐 [测试用例示例.xmind](references/测试用例示例.xmind)。

**多格式一致性**：MD 验证点、CSV 用例、XMind 叶子节点须可互相追溯（CSV 可对同一验证点细化多条，但不可遗漏），模块/子模块命名三者保持一致。

### Step6：风险标记

- 高风险：支付/权限/审核日志、SQL 变更、核心登录逻辑、接口鉴权、数据删除逻辑、批量操作、前后端接口字段大规模调整；必须追加异常、并发、脏数据和跨端联调场景。
- 中风险：普通业务查询、页面展示、非核心字段修改。
- 低风险：注释调整、日志打印、样式 UI 微调、常量文案修改。

### Step7：输出约束规则

1. 用例与 diff 改动点一一绑定，覆盖完整请求链路，不生成与本次 PR 无关的旧用例。
2. 按需输出 CSV / MD / XMind；多格式使用同一主文件名，模块、子模块及验证点可互相追溯。
3. 文件名遵循 `PR用例-{端}-{源分支短名}-yyyyMMdd`，将 `/` 替换为 `-`；同日同分支重复分析追加 `-HHmm`。
4. 有用户样例时，对齐其字段、层级、粒度、术语和文风。
5. 联动场景先分别梳理前后端改动，再合并用例并区分单端自测与两端联测。

## 三、边界

1. 仅分析当前源、目标分支差异；批量 PR 分别分析、命名和输出。
2. 只产出可执行用例文本，不自动运行测试或接口。
3. UI 微调只写页面校验点，不写像素级步骤；二进制、图片和静态资源单列替换校验项。
4. 前后端仓库独立解析，避免混淆路径和逻辑。

## 四、自检清单

- [ ] 已对照 `references/` 下 csv / md / xmind 示例格式
- [ ] 用例与本次 diff 改动点一一绑定，无无关冗余
- [ ] 正向 / 反向 / 边界 / 容错 / 回归（及联调场景，如有）均已覆盖
- [ ] 高风险改动已追加异常/并发/脏数据等场景
- [ ] 步骤可执行、预期可判定
- [ ] 用例从用户角色、操作路径和可观察结果出发，不以代码实现代替用户场景
- [ ] 文件命名符合 `PR用例-{端}-{源分支短名}-yyyyMMdd`，且按用户指定格式输出
- [ ] CSV 表头与导入样例完全一致；MD/XMind 层级同构
