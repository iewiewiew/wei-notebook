---
name: 分析 Pull Request 差异输出测试用例
description: 针对开发提交的 Pull Request，自动比对分支代码差异，精准识别代码改动范围与逻辑变更，针对性生成覆盖改动点的测试用例，保障迭代功能稳定、改动逻辑可测。使用示例：帮我分析 Pull Request 差异输出测试用例到指定目录下的测试用例-yyyyMMdd.md，命令：git diff origin/feat/add-jira-tag-association origin/premium/release-v260430-geely
---

# 分析 Pull Request 差异输出测试用例

## 基本信息
后端仓库目录：/Users/menghuawei/workspace/work-project/gitee
前端仓库目录：/Users/menghuawei/workspace/work-project/gitee-ent-web
测试用例目录：/Users/menghuawei/workspace/my-project/gitee-work/02.需求测试/PR测试用例集合
测试用例命名：测试用例-yyyyMMdd.md

## 使用场景
- 开发完成功能 / BUG 修复，提交 Pull Request 待合并时；
- 代码合并前需要做测试准入评估，明确改动点测试范围；
- 迭代快速交付场景，需要高效产出对应改动的测试用例；
- 代码逻辑重构、接口调整、参数变更、条件判断修改等代码变更场景；
- 需管控代码合并质量，防止无测试覆盖的代码直接上线。

## 指令
- 接收并解析 PR 基础信息，包含关联分支、变更文件列表、代码 diff 内容；
- 分类梳理代码改动类型：新增代码、修改逻辑、删除代码、参数调整、条件分支变动、依赖引入等；
- 逐一拆解每处改动的业务逻辑、执行链路、输入输出、异常场景；
- 结合改动点梳理正向场景、反向场景、边界值、异常容错、回归关联场景；
- 按照标准测试用例格式，包含用例标题、前置条件、操作步骤、预期结果，批量输出；
- 标记高风险改动模块，补充重点测试注意事项与回归建议；
- 保证测试用例和代码改动强绑定，无无关冗余用例，覆盖全部变更逻辑。
