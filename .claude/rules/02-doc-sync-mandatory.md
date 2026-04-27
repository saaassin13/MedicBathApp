---
description: 需求、设计、API、使用指南等文档必须与代码同步更新
globs: ["**/*.md", "**/*.py", "**/*.js", "**/*.ts", "**/*.dart", "**/*.swift", "**/*.kt", "**/*.java", "**/*.tsx", "**/*.jsx"]
alwaysApply: true
---

# 文档级联更新强制规范

## 触发条件
当代码变更涉及以下任何一项时，必须更新对应的文档：

| 变更类型 | 必须更新的文档 |
|---------|--------------|
| 新增/修改环境变量 | README.md 或 .env.example 中的说明 |
| 修改 API 接口（路由/参数/响应） | 见 `docs/.project-conventions.md` → API 文档路径 |
| 修改数据库 Schema | 见 `docs/.project-conventions.md` → 数据库路径 |
| 修改核心业务流程 | 见 `docs/.project-conventions.md` → 架构设计路径 |
| 修复 bug | CHANGELOG.md 以及见 `docs/.project-conventions.md` → Bug 修复路径 |
| 变更配置项 | 见 `docs/.project-conventions.md` → 配置说明路径 |

## 执行流程
1. 在修改代码之前，先列出本次变更影响的文档清单
2. 在修改代码的同时，立即更新文档（使用同一个工具调用批次）
3. 在提交代码之前，运行 .claude/scripts/check-doc-sync.sh（假设你有这个脚本，AI 可模拟检查）

## AI 输出格式要求
当用户要求修改代码时，AI 必须先输出：

```markdown
📄 **文档影响分析**
本次变更将影响以下文档：
- [ ] `docs/api/user.md` - 需要更新 `/login` 响应字段
- [ ] `README.md` - 需要修改安装步骤

我将同步更新这些文档，不会遗漏。
```

如果用户说"不用更新文档"，AI 必须警告："跳过文档更新可能导致项目文档与代码不一致，建议至少记录一个 TODO 任务。"
