# Global agent preferences

Shared instructions for every AI coding session on this machine. They live in
`~/.config/agent/AGENTS.md`; each tool is pointed at this file (Claude Code via
`~/.claude/CLAUDE.md`). Project-level instructions take precedence over anything here.

## Git & commits

- Commits: use the `commit` skill — it defines the message convention, how to validate
  against commitlint, and the commit workflow.
- Never `git push` or create commits unless I explicitly ask.
- Prefer small, focused commits over one large mixed commit.

## Code review

- For a read-only critique of changes, use the `review` skill.

## Working style

- Be concise. Lead with the answer, then the reasoning if needed.
- When editing code, match the style, naming, and conventions of the surrounding file.
- Ask before doing anything destructive or hard to reverse.
- Don't add comments that just restate the code.
