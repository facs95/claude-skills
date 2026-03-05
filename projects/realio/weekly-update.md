# Weekly Project Update

Generate a weekly update summary for the "Platform - Projects/Issuance System - V1" project.

## Your Task

1. **Determine the time range**:
   - Default: Last 7 days from today
   - Can be overridden via argument: $ARGUMENTS (e.g., "last 2 weeks", "since Jan 15")

2. **Gather data from multiple sources**:

   ### From Linear:
   - Query issues for project ID: `27c03a0c-324e-4fdd-8fb1-bbde4dac8767`
   - Get issues updated in the time range
   - Categorize by status changes (moved to Done, In Progress, etc.)

   ### From Git:
   - Run: `git log --oneline --since="7 days ago" --all --grep="REA-" 2>/dev/null || git log --oneline -50`
   - Look for commits related to REA-xxx issues
   - Check for PRs merged to `stage` branch

3. **Generate the update** in this format:

   ```markdown
   # Weekly Update: Platform - Projects/Issuance System V1
   **Period:** [Start Date] - [End Date]
   **Author:** Freddy Caceres

   ## Summary
   [2-3 sentence high-level description of the week's focus areas and key accomplishments. E.g., "This week focused on completing the token management admin endpoints and fixing several document-handling bugs. The clawback/mint/burn pipeline is now fully wired, and self-custody treasury wallets are live. Token factory deployment is in review and fee sponsorship work has started."]

   ## Completed This Week
   - [REA-XXX](linear-url): Brief description of what was done
   - [REA-XXX](linear-url): Brief description

   ## In Review
   - [REA-XXX](linear-url): Brief description

   ## In Progress
   - [REA-XXX](linear-url): Current status/what's being worked on
   - [REA-XXX](linear-url): Current status

   ## Blockers / Risks
   - [Description of any blockers or risks, or "None" if clear]

   ## Upcoming Next Week
   - [Planned work items]

   ## Key Metrics (if available)
   - Issues completed: X
   - Issues in review: X
   - Issues in progress: X
   - PRs merged: X
   ```

   **Important:** Only include backend/platform issues from this project. Do not include frontend, mobile, bridge, staking, or other unrelated work.

4. **Post the update**:
   - Ask user where to post: Linear project update, clipboard, or file
   - If Linear: Use `mcp__linear-server__create_document` or update existing

## Data Collection Commands

```bash
# Git commits in last 7 days
git log --oneline --since="7 days ago" --all

# PRs merged to stage
git log stage --oneline --since="7 days ago" --merges

# Commits with REA- references
git log --oneline --since="7 days ago" --all --grep="REA-"
```

## Linear Queries

- Completed issues: `state: "Done"` + `updatedAt: "-P7D"`
- In Progress: `state: "In Progress"` + `project: "27c03a0c-324e-4fdd-8fb1-bbde4dac8767"`
- Recently updated: `updatedAt: "-P7D"` + `project: "27c03a0c-324e-4fdd-8fb1-bbde4dac8767"`

## Output Options

After generating, ask user:
1. **Copy to clipboard** - For pasting elsewhere
2. **Save to file** - Create `/tmp/weekly-update-[date].md`
3. **Post to Linear** - Create as project document
