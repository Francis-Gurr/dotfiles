# Global agent preferences

Shared instructions for every AI coding session on this machine. They live in
`~/.config/agent/AGENTS.md`; each tool is pointed at this file (Claude Code via
`~/.claude/CLAUDE.md`). Project-level instructions take precedence over anything here.

## Git & commits

- Commits: use the `commit` skill — it defines the message convention, how to validate
  against commitlint, and the commit workflow.
- PR/MR descriptions: use the `pr-description` skill.
- Prefer small, focused commits over one large mixed commit.
- Prefer rebasing and a linear branch history over merge commits.
- Never create commits unless I explicitly ask; plain `git push` is fine.
- Never `git push --force`. Only `git push --force-with-lease` if I explicitly ask.

## Code review

- For a read-only critique of changes, use the `review` skill.

## Code style

When writing or editing code, follow the conventions in `STYLE.md` (naming, comments,
simplicity, consistency). The `review` skill critiques against the same file.

@~/.config/agent/STYLE.md

## Working style

- Be concise. Lead with the answer, then the reasoning if needed.
- Ask before doing anything destructive or hard to reverse.
