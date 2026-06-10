---
description: Create a git commit for the current changes
---
Look at the current repository state and create a single, well-scoped git commit
following the conventions in the `committing` skill. Do not push.

Status:
!`git status --short`

Staged + unstaged diff:
!`git diff HEAD`

If nothing is staged, stage the relevant changes yourself first. If the changes are
unrelated, tell me and propose splitting them into separate commits instead.
