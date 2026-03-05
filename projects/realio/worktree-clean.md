# Worktree Cleanup

Clean up the current git worktree, its tmux session, and branch. Before cleaning up, post a summary of the implementation to the Linear ticket.

## Your Task

1. **Get the current branch name** by running:
   ```bash
   git rev-parse --abbrev-ref HEAD
   ```
   - Extract the Linear ticket ID from the branch name (e.g., `facs95/REA-910/...` → `REA-910`)

2. **Gather implementation context**:
   - Run `git log stage..HEAD --oneline` to see all commits made on this branch
   - Run `git diff stage..HEAD --stat` to see which files were changed
   - Review the conversation history for key findings, decisions, and any deviations from the original plan

3. **Post a summary comment to the Linear ticket** using `mcp__linear-server__create_comment`:
   - Use the extracted ticket ID to find the issue
   - Write a structured comment with this format:

   ```markdown
   ## Implementation Summary

   ### What was done
   - [Bullet points of what was implemented]

   ### Key decisions & changes from original plan
   - [Any deviations from the ticket's original spec, architectural choices made, trade-offs]

   ### Files changed
   - [List of significant files modified/created, grouped by area]

   ### Findings & notes
   - [Anything discovered during implementation that's worth documenting — gotchas, edge cases, things to watch out for]
   ```

   - Keep it concise but thorough — this is the source of truth for what happened
   - Skip sections that don't apply (e.g., if there were no deviations, omit that section)

4. **Confirm with the user** before removing the worktree:
   - Show the comment that was posted
   - Show the branch name that will be removed
   - Ask if they want to proceed with cleanup

5. **Remove the worktree** by running:
   ```bash
   gwt --remove <branch-name>
   ```
   - This kills the tmux session, removes the worktree, deletes the local branch, and cleans up the Claude Code history symlink

6. **Confirm completion** with:
   - Linear ticket comment posted
   - Branch removed
   - Tmux session killed
   - Worktree removed
