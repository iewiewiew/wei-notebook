[TOC]

<h1 align="center">Skill使用文档</h1>

> By：weimenghua  
> Date：2026.03.12 
> Description：



### Agent Skills

Agent Skills（智能体技能）是一个用于为 AI 智能体扩展专门能力的开放标准。Skills 将特定领域的知识和工作流封装起来，智能体可以调用这些 Skills 来执行特定任务。  
技能是一个可移植、支持版本控制的包，用于让 Agent 学会如何执行特定领域的任务。技能可以包含脚本、模板和参考资料，Agent 可以使用其工具对这些内容进行操作。

[skills.sh](https://skills.sh)  
[awesome-agent-skills](https://github.com/skillmatic-ai/awesome-agent-skills)  
[Cursor 使用 Agent Skill](https://cursor.com/cn/docs/context/skills)

项目级目录：.cursor/skills/  
用户级（全局）：~/.cursor/skills/

SKILL 目录结构
```
my-skill/
├── SKILL.md          # 必须：指令 + 元数据
├── scripts/          # 可选：可执行脚本
│   └── helper.py
├── references/       # 可选：参考文档
│   └── REFERENCE.md
└── assets/           # 可选：模板、资源
└── template.json
```

使用示例1：
[frontend-design SKILL.md](https://github.com/anthropics/claude-code/blob/main/plugins/frontend-design/skills/frontend-design/SKILL.md)
提问：
1. 帮我设计一个开发者工具的落地页
2. 帮我设计一个软件测试工具的落地页

使用示例2:  
[ui-ux-pro-max SKILL.md](https://github.com/likaia/nginxpulse/blob/main/.codex/skills/ui-ux-pro-max/SKILL.md)

使用示例3:
[update-docs](https://github.com/vercel/next.js/tree/canary/.claude/skills/update-docs)
该 Skill 是一套用于更新 Next.js 项目文档的引导式工作流，核心作用是帮助你根据源代码的变更，来分析、更新和创建相关的文档，确保代码和文档保持同步。它特别为审查 Pull Request (PR) 时的文档完整性检查而设计，通过一系列标准化的步骤来规范文档的修改过程。

使用示例4:  
[uni-app](https://github.com/uview-pro/skills)

使用示例5:
[Superpowers](https://github.com/obra/superpowers)
npx skills add https://github.com/obra/superpowers --skill brainstorming -y

[研发场景十大热门 Skill 推荐](https://docs.trae.cn/ide/top-10-recommended-skills-for-development-scenarios)

实践：帮我设计一个适合在 Cursor 使用的 Python Pytest API 自动化测试 SKILL，并说明如何使用 SKILL

npx skills 用法示例

```
npx skills init

npx skills find <query>
npx skills find Superpowers

npx skills add <owner/repo@skill>
npx skills add https://github.com/supercent-io/skills-template --skill vercel-react-best-practices
```

在 Qoder 命令框输入：/create-skill Create this skill for current project: