# Worktree Setup from Linear Ticket

Set up a new git worktree with a tmux session for a Linear ticket, install dependencies, and get ready to work.

## Your Task

1. **Parse the input**: $ARGUMENTS
   - Extract the Linear ticket identifier (e.g., `REA-1234`)
   - If no argument provided, ask for the Linear ticket ID

2. **Fetch the Linear ticket** using the `mcp__linear-server__get_issue` tool:
   - Use the ticket identifier to get the issue details
   - Extract the **title** from the ticket

3. **Derive the branch name** following the project convention:
   - Format: `facs95/<TICKET-ID>/<short-description-kebab-case>`
   - Convert the ticket title to a short kebab-case description (max 5-6 words, lowercase, hyphens)
   - Remove filler words (the, a, an, for, to, in, on, etc.) if it helps keep it concise
   - Example: ticket REA-1043 "Fix Investment Round Document Upsert Partial Index" → `facs95/REA-1043/fix-inv-round-doc-upsert-partial-index`

4. **Create the worktree and tmux session** by running:
   ```bash
   gwt <branch-name> --base stage
   ```
   - This creates a worktree branching off `stage` and opens a tmux session
   - The `gwt` command will handle worktree creation and tmux session setup automatically

5. **Install dependencies** in the new worktree:
   ```bash
   cd <worktree-path> && npm install
   ```
   - The worktree path follows the pattern: `../.worktrees/realio/<branch-name>`
   - Run `npm install` to set up all node_modules for the new worktree

6. **Confirm completion** with:
   - Linear ticket: identifier + title
   - Branch name created
   - Worktree path
   - Tmux session name
   - Confirmation that dependencies are installed

## Important Notes

- Always branch from `stage` — never use a different base branch
- The `gwt` command must NOT be run with `--no-tmux` — we want the tmux session
- If the worktree or branch already exists, `gwt` will report it — inform the user
- If `npm install` fails, report the error but don't block — the worktree is still usable
