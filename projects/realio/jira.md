# Jira Ticket Creation

Create a Jira ticket based on the user's request, following all team guidelines.

## Your Task

1. **Understand the request** from the argument: $ARGUMENTS
   - If no argument provided, ask what ticket needs to be created

2. **Determine ticket type**:
   - **Story**: New feature or capability work
   - **Bug**: Something broken that needs fixing
   - **Tech Debt**: Refactoring, cleanup, or improvement work

3. **Validate epic alignment**:
   - Default epic: **RP-2774** "Platform - Projects/Issuance System - V1"
   - If work doesn't clearly fit this epic, ask for confirmation or alternative

4. **Apply appropriate labels**:
   | Label | Use For |
   |-------|---------|
   | `freehold-mobile` | Mobile client work |
   | `freehold-web` | Web client work |
   | `platform` | Backend/platform work |
   | `devops` | Infrastructure/CI/CD |
   | `bug` | Bug fixes |
   | `groom` | Needs review |

5. **For bugs, gather**:
   - Environment (prod/staging/dev)
   - Steps to reproduce
   - Expected vs actual behavior
   - Any relevant logs

6. **Create the ticket** using the Atlassian MCP with:
   - Clear, action-oriented title
   - Concise description
   - Assignee: Freddy Caceres
   - Status: "Selected For Development"
   - Parent/Epic: RP-2774 (or confirmed alternative)
   - Appropriate labels

7. **Confirm creation** with ticket link and summary

## Ticket Placement Quick Reference

| Situation | Epic | Label |
|-----------|------|-------|
| Active feature work | Feature epic | surface label |
| Future idea | Icebox | `groom` |
| Bug (no active epic) | Sustaining | `bug` |
| Tech debt | Tech Debt | — |
| Unsure | Icebox | `groom` |
