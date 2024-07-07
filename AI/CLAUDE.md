# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a personal knowledge base (Obsidian-based) for a software test engineer, containing 170+ markdown files organized by technical domain. Content is primarily in Chinese (中文).

## Repository Structure

Knowledge is organized into domain-specific directories:

- **AI/** - AI products, VibeCoding, Agent testing, MCP usage, prompt engineering
- **SoftwareTest/** - Testing methodologies (App, API, performance, security, monitoring), JMeter, test case design
- **DevOps/** - Docker, Kubernetes, Jenkins, Ansible, CI/CD tools (GiteeGo, Argo)
- **Database/** - MySQL, PostgreSQL, MongoDB, Redis, Elasticsearch, ClickHouse, Hive, GraphQL, Supabase
- **Middleware/** - Nginx, Kafka, Apollo, Dubbo, Zookeeper, MinIO, Sonar, Nexus
- **Linux/** - Shell scripts (in `Linux/Shell/`), commands, system administration
- **Git/** - Git workflows, code hosting platforms, .gitignore templates
- **CSBasic/** - Network, OS, Windows fundamentals
- **GeneralKnowledge/** - Non-technical topics, technical documentation standards
- **Chaos/** - Chaos engineering (ChaosBlade, ChaosMesh), high availability testing
- **Misc/** - Tools (VSCode, IDEA, Chrome, Mac), Blog, BigData, SSO, Drawio diagrams

## Content Patterns

- Markdown files use `[TOC]` for table of contents generation
- Headers typically use `<h1 align="center">Title</h1>` format with metadata (author, date, description)
- Images are stored in `images/` subdirectories within each topic folder
- Shell scripts and Python utilities are located in `Linux/Shell/` and `Chaos/` directories
- Mind maps stored as `.mm` and `.xmind` files in Chaos directory

## Key Files

- `README.md` - Repository introduction and knowledge system overview (Chinese)
- `docs/` - Contains overview diagrams (知识体系建设, 质量保障体系建设, 测试工程师技能图谱)
- `GeneralKnowledge/技术文档规范.md` - Technical documentation standards

## Working with this Repository

When adding or modifying content:
- Maintain the domain-specific directory organization
- Use Chinese for content unless specifically technical terms
- Follow the existing header pattern with TOC and centered H1 titles
- Store images in the topic's `images/` subdirectory
- Shell scripts should include executable permissions and shebang lines
