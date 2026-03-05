# Realio Project Skills

Skills for the [Realio](https://realio.fund) platform — an NX monorepo (NestJS + Next.js) using Linear for project management and Jira for legacy tracking.

## Skills

### `/worktree` — Worktree Setup from Linear Ticket
Takes a Linear ticket ID (e.g., `REA-1234`), fetches the title, derives a branch name following the team's naming convention, and runs `gwt` to create a worktree + tmux session branching from `stage`. Installs dependencies (`npm install`) in the new worktree automatically.

### `/worktree-clean` — Worktree Cleanup
Gathers all commits and changed files from the current worktree branch, reviews the conversation history, and posts a structured implementation summary to the Linear ticket. After confirmation, runs `gwt --remove` to tear down the worktree, tmux session, branch, and Claude Code history symlink.

### `/linear-issue` — Linear Issue Creation
Creates Linear issues in the "Platform - Projects/Issuance System - V1" project with structured templates for bugs (environment, repro steps, expected/actual behavior) and features/tasks (summary, acceptance criteria). Auto-assigns to the current user.

### `/jira` — Jira Ticket Creation
Creates Jira tickets with proper epic alignment, labels, and templates. Supports stories, bugs, and tech debt. Uses the Atlassian MCP for ticket creation.

### `/weekly-update` — Weekly Project Update
Queries Linear issues and git history to generate a structured weekly update covering completed work, in-review items, in-progress work, blockers, and upcoming tasks. Can post to Linear, save to file, or copy to clipboard.

## Setup

Symlink all skills into your Realio project's `.claude/commands/` directory:

```bash
cd /path/to/realio
mkdir -p .claude/commands

for file in ~/Repositories/claude-skills/projects/realio/*.md; do
  name=$(basename "$file")
  [[ "$name" == "README.md" ]] && continue
  ln -sf "$file" .claude/commands/"$name"
done
```

## Customization

These skills contain project-specific values you may need to adjust:

- **Branch prefix**: `facs95/` in `worktree.md` and `worktree-clean.md` — change to your username
- **Base branch**: `stage` — change if your project uses a different base
- **Linear project ID**: `27c03a0c-324e-4fdd-8fb1-bbde4dac8767` in `linear-issue.md` and `weekly-update.md`
- **Linear team ID**: `4f0b2c2b-44d6-4918-bdd0-448661045692` in `linear-issue.md`
- **Jira epic**: `RP-2774` in `jira.md`
- **Assignee**: `Freddy Caceres` in `jira.md` — change to your name
