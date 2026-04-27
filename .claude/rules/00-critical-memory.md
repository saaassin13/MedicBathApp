---
description: 强制记录所有决策、Bug 修复、Badcase，构建项目永久记忆
globs: ["**/*.md", "**/*.py", "**/*.js", "**/*.ts", "**/*.dart", "**/*.swift", "**/*.kt", "**/*.java", "**/*.tsx", "**/*.jsx"]
alwaysApply: true
---

# 项目关键记忆强制记录规范

## 目标
将一切不重复踩坑的信息持久化到项目中，即使会话丢失，新会话也能快速恢复上下文。

## 1. 决策记录（Architecture Decision Records, ADR）
存放路径：见 `docs/.project-conventions.md` → 技术决策路径

文件名格式：YYYY-MM-DD-简短描述.md

模板：

```markdown
# 决策：使用 XXX 方案
**日期**：2026-04-22
**背景**：遇到了 ... 问题
**选项**：A方案（...）、B方案（...）
**选择**：A，因为 ...
**后果**：以后所有类似场景都必须遵循此决策
```

## 2. Bug 修复记录
存放路径：见 `docs/.project-conventions.md` → Bug 修复路径

文件名格式：BUG-XXX-简短描述.md（XXX 自增编号）

模板：

```markdown
# Bug #001：登录时偶发 token 过期
**现象**：...
**根因**：...
**修复方案**：...
**验证方法**：...
**防止复发**：添加单元测试 / 修改代码规范
```

## 3. Badcase / 陷阱记录
存放路径：见 `docs/.project-conventions.md` → 教训记录路径

文件名格式：LESSON-XXX-简短描述.md

模板：

```markdown
# 教训：不要在生产环境使用某个函数
**场景**：我们尝试用 `json.loads()` 处理大文件
**后果**：内存溢出
**正确做法**：使用 `ijson` 流式解析
**触发条件**：文件 > 100MB
```

# AI 行为强制要求

当修复一个 Bug 时：
- 修复完成后，必须检查 Bug 修复路径（见 `docs/.project-conventions.md`）下是否已有类似记录
- 如果没有，立即创建一条新记录
- 在回复末尾输出：`📝 Bug 修复已记录到 [路径]`

当做出一个技术决策时（例如：选择某个库、架构方案、绕过某个问题）：
- 必须在技术决策路径（见 `docs/.project-conventions.md`）下创建 ADR 文件

当遇到一个值得记住的陷阱时（例如：某个函数在特定输入下崩溃）：
- 必须在教训记录路径（见 `docs/.project-conventions.md`）下记录，并标注复现条件

新会话启动时的记忆加载
AI 应在每次会话开始时读取 `docs/.project-conventions.md` 获取路径定义，然后执行路径检查。

并输出："📚 已加载项目记忆：最近 X 个决策 / Y 个 bug 修复 / Z 个教训。"
