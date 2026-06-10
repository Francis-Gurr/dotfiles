# Global preferences

These instructions apply to every opencode session on this machine (they live in
`~/.config/opencode/AGENTS.md`). Project-level `AGENTS.md` files take precedence over
anything here. This is the opencode equivalent of a global "rules"/memory file.

## Git & commits

- Commit messages: follow the `committing` skill (load it before committing). It
  defines the convention and how to validate against commitlint.
- Never `git push` or create commits unless I explicitly ask.
- Prefer small, focused commits over one large mixed commit.

## Working style

- Be concise. Lead with the answer, then the reasoning if needed.
- When editing code, match the style, naming, and conventions of the surrounding file.
- Ask before doing anything destructive or hard to reverse.
- Don't add comments that just restate the code.
