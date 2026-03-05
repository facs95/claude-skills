# Linear Issue Creation

Create a Linear issue for the "Platform - Projects/Issuance System - V1" project using the team's templates.

## Your Task

1. **Understand the request** from the argument: $ARGUMENTS
   - If no argument provided, ask what issue needs to be created

2. **Determine issue type**:
   - **Bug**: Something broken that needs fixing
   - **Issue**: Feature, task, spec, or any other work item

3. **Default Configuration**:
   - **Project**: Platform - Projects/Issuance System - V1 (ID: `27c03a0c-324e-4fdd-8fb1-bbde4dac8767`)
   - **Team**: Realio (ID: `4f0b2c2b-44d6-4918-bdd0-448661045692`)
   - **Assignee**: me (Freddy Caceres) - always assign to current user
   - **Status**: Backlog
   - **Priority**: Only set if explicitly requested (1=Urgent, 2=High, 3=Normal, 4=Low)

4. **For BUGS, use this template**:

```markdown
## Summary

[One sentence: what's broken]

## Environment

- **Platform:** [mobile/web/backend]
- **Environment:** [prod/staging/dev]
- **Version:** [app version or commit]
- **Device/Browser:** [if relevant]

## Steps to Reproduce

1.
2.
3.

## Expected Behavior

[What should happen]

## Actual Behavior

[What happens instead]
```

5. **For ISSUES (features/tasks/specs), use this template**:

```markdown
## Summary

[One sentence: what we're building and why]

## Acceptance Criteria

- [ ] [Criterion 1]
- [ ] [Criterion 2]
- [ ] [Criterion 3]

## Notes

[Optional: context, links, designs, technical notes]
```

6. **Gather information**:
   - For bugs: Ask about environment, steps to reproduce, expected/actual behavior
   - For issues: Ask about acceptance criteria if not clear from request

7. **Create the issue** using `mcp__linear-server__create_issue` with:
   - Clear, action-oriented title
   - Description using the appropriate template above
   - **Assignee**: "me" (always assign to current user)
   - Apply `Bug` label for bugs

8. **Confirm creation** with:
   - Issue identifier (e.g., REA-XXX)
   - Issue URL
   - Brief summary of what was created

## Examples

**Bug request:** "Users can't submit investments on mobile"
- Type: Bug
- Title: "Users cannot submit investments on mobile"
- Use Bug Template, gather environment details

**Feature request:** "Add endpoint to check ticker availability"
- Type: Issue
- Title: "Add endpoint to check ticker availability"
- Use Issue Template with acceptance criteria

## Labels Reference

| Label | Use For |
|-------|---------|
| `Platform` | Backend/platform work |
| `Bug` | Bug fixes (always apply for bugs) |
