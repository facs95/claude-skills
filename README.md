# Claude Skills

A version-controlled collection of [Claude Code](https://claude.ai/code) skills (slash commands) and shell tools, designed to be shared across machines and teammates.

## Structure

```
claude-skills/
├── install.sh                    # Symlinks everything into place
│
├── tools/                        # Shell scripts (go to ~/.local/bin/)
│   └── gwt                       # Git worktree + tmux + Claude history manager
│
├── global/                       # Global skills (go to ~/.claude/commands/)
│   ├── linear.md                 # Linear ticket management
│   ├── plan.md                   # Implementation planning
│   ├── implement.md              # Plan execution
│   ├── research.md               # Codebase research
│   ├── setup-worktree-skills.md  # Meta-skill: generate project worktree skills
│   ├── chat-sdk-gen-docs.md      # Chat SDK documentation generation
│   ├── gen-docs-init.md          # Documentation generation init
│   └── gen-docs.md               # Documentation generation
│
└── projects/                     # Project-specific skills
    └── realio/                   # (go to <project>/.claude/commands/)
        ├── worktree.md           # Worktree setup from Linear ticket
        ├── worktree-clean.md     # Worktree cleanup
        ├── linear-issue.md       # Linear issue creation
        ├── jira.md               # Jira ticket creation
        └── weekly-update.md      # Weekly project update
```

## Global Skills

### `/plan` — Implementation Planning
Interactive, multi-step skill for creating detailed implementation plans. Reads tickets and codebase context, spawns parallel research agents, asks clarifying questions, and produces phased plans with success criteria. Plans are saved to `thoughts/shared/plans/`.

### `/implement` — Plan Execution
Executes an approved plan from `thoughts/shared/plans/`. Reads the plan and all referenced files, implements each phase sequentially, runs success criteria checks, and updates checkboxes in the plan as sections are completed. Handles mismatches between plan and reality by stopping and asking for guidance.

### `/research` — Codebase Research
Conducts comprehensive codebase research by spawning parallel sub-agents to explore different areas concurrently. Synthesizes findings into a structured research document with file references, architecture insights, and historical context. Saves output to `thoughts/shared/research/`.

### `/linear` — Linear Ticket Management
Creates and queries Linear tickets with proper labels, priorities, and structured descriptions. Supports bugs, features, improvements, and ideas with appropriate templates for each type.

### `/setup-worktree-skills` — Worktree Skills Generator
Meta-skill that analyzes the current project (package manager, branch convention, base branch) and generates project-specific `/worktree` and `/worktree-clean` skills tailored to that project's workflow. Integrates with `gwt`, Linear, and Claude Code history sharing.

### `/gen-docs-init` — Documentation Generation Init
Interactive setup for documentation generation. Asks questions about the product, features, audience, and tech stack, then creates a `doc-gen.config.json` and starter guide files optimized for RAG systems.

### `/gen-docs` — Documentation Generation
Analyzes a codebase and generates vectorization-optimized documentation chunks (JSON files) suitable for RAG retrieval. Produces API, component, type, and function docs with semantic metadata, code references, and a manifest file.

### `/chat-sdk-gen-docs` — Chat SDK Documentation Generation
Specialized variant of `/gen-docs` tailored for Chat SDK projects. Same RAG-optimized chunk output format.

## Tools

### `gwt` — Git Worktree + Tmux Manager
Shell script that creates git worktrees in a sibling `.worktrees/` directory, opens tmux sessions for each, and symlinks Claude Code project history so conversations are shared between worktree and main repo. Supports `--base`, `--list`, `--remove`, and `--no-tmux` flags.

## Installation

### Prerequisites

- [Claude Code](https://claude.ai/code) CLI installed
- `~/.local/bin/` in your `$PATH` (for shell tools)

### Install Global Skills & Tools

```bash
git clone <repo-url> ~/Repositories/claude-skills
cd ~/Repositories/claude-skills
chmod +x install.sh
./install.sh
```

This symlinks:
- All `.md` files from `global/` into `~/.claude/commands/`
- All scripts from `tools/` into `~/.local/bin/`

Use `--force` to replace existing files:

```bash
./install.sh --force
```

### Install Project-Specific Skills

Project skills are **not** auto-installed. Symlink them manually into your project's `.claude/commands/` directory:

```bash
# Example: install realio skills
cd /path/to/realio/project
mkdir -p .claude/commands

ln -sf ~/Repositories/claude-skills/projects/realio/worktree.md .claude/commands/worktree.md
ln -sf ~/Repositories/claude-skills/projects/realio/worktree-clean.md .claude/commands/worktree-clean.md
ln -sf ~/Repositories/claude-skills/projects/realio/linear-issue.md .claude/commands/linear-issue.md
ln -sf ~/Repositories/claude-skills/projects/realio/jira.md .claude/commands/jira.md
ln -sf ~/Repositories/claude-skills/projects/realio/weekly-update.md .claude/commands/weekly-update.md
```

The install script will print these commands for you after running.

## Adding New Skills

### Global Skill

1. Create a new `.md` file in `global/`
2. Run `./install.sh` (or `./install.sh --force` to update existing symlinks)

### Project-Specific Skill

1. Create a new directory under `projects/<project-name>/` if it doesn't exist
2. Add your `.md` file there
3. Symlink it into the project's `.claude/commands/` directory

### Shell Tool

1. Add your script to `tools/`
2. Run `./install.sh` to symlink it into `~/.local/bin/`

## Skill Format

Skills are Markdown files that Claude Code loads as slash commands. They typically contain:

- Instructions for Claude on how to perform a task
- Input parameters (using `$ARGUMENTS` placeholder)
- Step-by-step procedures
- Tool usage patterns

Example:

```markdown
# My Skill

When invoked, do the following:

1. Step one
2. Step two
3. Step three

Use the argument: $ARGUMENTS
```

Invoke with `/my-skill some arguments` in Claude Code.
