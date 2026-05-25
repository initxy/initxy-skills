---
name: obsidian-vault
description: 在 Obsidian vault 中搜索、创建和管理带 wikilinks 与 index notes 的笔记。当用户想查找、创建或整理 Obsidian 笔记时使用。
---

# Obsidian Vault

## Vault 位置

`~/ai/brain`

基本是根目录扁平结构。

## 命名约定

- Index notes 聚合相关主题，如 `Skills Index.md`。
- 所有笔记名用 Title Case。
- 不用文件夹组织；用链接和 index notes。

## 链接

- 使用 Obsidian `[[wikilinks]]`。
- 笔记底部链接依赖或相关笔记。
- Index notes 只是 `[[wikilinks]]` 列表。

## 工作流

### 搜索笔记

```bash
find "$HOME/ai/brain" -name "*.md" | grep -i "keyword"
grep -rl "keyword" "$HOME/ai/brain" --include="*.md"
```

### 创建笔记

1. 文件名用 Title Case。
2. 内容作为一个学习单元。
3. 底部加入相关 `[[wikilinks]]`。
4. 若属于编号序列，使用层级编号。

### 找 backlinks

```bash
grep -rl "\\[\\[Note Title\\]\\]" "$HOME/ai/brain"
```

### 找 index notes

```bash
find "$HOME/ai/brain" -name "*Index*"
```
