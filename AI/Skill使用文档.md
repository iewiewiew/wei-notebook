[TOC]

<h1 align="center">Skill使用文档</h1>

> By：weimenghua  
> Date：2026.03.12  
> Description：  



## Agent Skills

Agent Skills（智能体技能）是一个用于为 AI 智能体扩展专门能力的开放标准。Skills 将特定领域的知识和工作流封装起来，智能体可以调用这些 Skills 来执行特定任务。  
技能是一个可移植、支持版本控制的包，用于让 Agent 学会如何执行特定领域的任务。技能可以包含脚本、模板和参考资料，Agent 可以使用其工具对这些内容进行操作。

参考文档
- [skills.sh](https://skills.sh)  
- [awesome-agent-skills](https://github.com/skillmatic-ai/awesome-agent-skills)  
- [claudeskills](https://claudeskills.info/)
- [Cursor 使用 Agent Skill 教程](https://cursor.com/cn/docs/context/skills)

- 项目级目录：.cursor/skills/  
- 用户级（全局）：~/.cursor/skills/
- 项目级所有工具：.agent/skills/

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



## npx skills 用法示例

```
npx skills init

npx skills find <query>
npx skills find Superpowers

npx skills add <owner/repo@skill>
npx skills add https://github.com/supercent-io/skills-template --skill vercel-react-best-practices
```



## 常用 SKILL
 
### frontend-design

[frontend-design SKILL.md](https://github.com/anthropics/claude-code/blob/main/plugins/frontend-design/skills/frontend-design/SKILL.md)
提问：
1. 帮我设计一个开发者工具的落地页
2. 帮我设计一个软件测试工具的落地页

### ui-ux-pro-max

[ui-ux-pro-max SKILL.md](https://github.com/likaia/nginxpulse/blob/main/.codex/skills/ui-ux-pro-max/SKILL.md)


### uni-app  

[uni-app](https://github.com/uview-pro/skills)

### Superpowers

[Superpowers](https://github.com/obra/superpowers)
npx skills add https://github.com/obra/superpowers --skill brainstorming -y

### taste-skill

去 AI 味设计：https://github.com/leonxlnx/taste-skill  
awesome-design-md：https://github.com/VoltAgent/awesome-design-md  
预览站点：getdesign.md/designmd.co，在线预览色值、组件效果   
把对应的 DESIGN.md 下载到项目根目录，使用 Claude Code / Cursor / Codex："基于 DESIGN.md，做一个 XX 页面"

Google Stitch 推了一个新概念叫 DESIGN，DESIGN.md 和 AGENTS.md 是兄弟文件

|文件|谁读|定义什么|
|---|---|---|
|`AGENTS.md`|编码 Agent|怎么构建项目|
|`DESIGN.md`|设计 Agent|项目长什么样、什么感觉|



## 知识碎片

在 Qoder 命令框输入：/create-skill Create this skill for current project:


## 设计 SKILL

Frontend Design
UI/UX Pro Max
Motion Skill
Design Tokens
Web Design Guidelines
identity-skill
vercel-domain