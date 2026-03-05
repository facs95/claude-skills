# Setup Worktree Skills for a Project

Generate project-specific `/worktree` and `/worktree-clean` skills (commands) for the current project. These skills integrate with `gwt`, Linear, and Claude Code history sharing.

## Your Task

1. **Analyze the current project** to determine:
   - Package manager and install command (e.g., `npm install`, `bun install`, `pnpm install`, `yarn`, `cargo build`, `pip install -r requirements.txt`, etc.)
   - Branch naming convention (check CLAUDE.md, recent git log, or ask the user)
   - Any post-install setup steps (e.g., build step, db migrations, env file copy)
   - Base branch to always branch from (e.g., `main`, `develop`, `stage` — check CLAUDE.md or ask)

2. **Create `.claude/commands/worktree.md`** in the project with these responsibilities:
   - Accept a Linear ticket (ID or URL) as `$ARGUMENTS`
   - Extract the ticket ID (e.g., `REA-1234`, `PROJ-567`)
   - Fetch the ticket from Linear using `mcp__linear-server__get_issue` to get the title
   - Derive a branch name following the project's convention, converting the title to a short kebab-case description (max 5-6 words, remove filler words)
   - Run `gwt <branch-name> --base <base-branch>` to create worktree + tmux session
   - Run the project's dependency install command in the new worktree
   - Confirm completion with: ticket info, branch name, worktree path, tmux session, install status

3. **Create `.claude/commands/worktree-clean.md`** in the project with these responsibilities:
   - Get the current branch name via `git rev-parse --abbrev-ref HEAD`
   - Extract the Linear ticket ID from the branch name
   - Gather implementation context:
     - `git log <base-branch>..HEAD --oneline` for commits
     - `git diff <base-branch>..HEAD --stat` for changed files
     - Review conversation history for key findings and decisions
   - Post a structured summary comment to the Linear ticket using `mcp__linear-server__create_comment` with this format:

     ```markdown
     ## Implementation Summary

     ### What was done
     - [Bullet points of what was implemented]

     ### Key decisions & changes from original plan
     - [Deviations from spec, architectural choices, trade-offs]

     ### Files changed
     - [Significant files modified/created, grouped by area]

     ### Findings & notes
     - [Gotchas, edge cases, things to watch out for]
     ```

   - Confirm with the user before cleanup (show comment posted + branch to remove)
   - Run `gwt --remove <branch-name>` to clean up worktree, tmux session, branch, and Claude Code history symlink

## Key Reminders for Both Skills

- `gwt` handles: worktree creation/removal, tmux session management, Claude Code history symlink (shares conversation history between worktree and main repo), and branch lifecycle
- Always use `--base <base-branch>` on create — never default to current branch
- The closing skill should always post to Linear before cleanup — Linear is the source of truth
- Skip empty sections in the implementation summary (e.g., if no deviations, omit that section)
- If dependency install fails, report it but don't block — the worktree is still usable

## Example Output

For a project using npm with `stage` as the base branch and `facs95/REA-XXXX/<description>` branch convention, the generated skills should match the pattern in the realio project's `.claude/commands/worktree.md` and `.claude/commands/worktree-clean.md`.

Adapt the branch prefix, base branch, install command, and any project-specific setup steps based on what you find in the current project.
