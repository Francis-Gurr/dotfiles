---
name: committing
description: Use when writing a git commit message — the house convention (Conventional Commits + a leading gitmoji matching the type, subject line only) and how to read/validate it against commitlint.
compatibility: opencode
---

[Conventional Commits](https://www.conventionalcommits.org) with a single subject line
only (no body, no footer) and a leading [gitmoji](https://gitmoji.dev) that matches the
type:

```
<emoji> <type>(<optional scope>): <subject>
```

- subject: imperative mood, lower-case, no trailing period
- `!` after the type/scope marks a breaking change (e.g. `✨ feat!:`)

```
✨ feat(auth): add password reset flow
🐛 fix: handle empty response from picker
♻️ refactor(snacks): extract git status helper
```

## commitlint is the source of truth

Repos set up from `~/.dotfiles/commitlint` enforce this with a commit-msg hook. Don't
reproduce the rules here — read them from the resolved config:

- Rules + the gitmoji for each type: `npx commitlint --print-config json`
  (emoji map under `prompt.questions.type.enum.<type>.emoji`, types under `type-enum`)
- Validate before committing: `printf '%s' "<message>" | npx commitlint` (exit 0 = valid)
- If a commit is rejected, fix only the rule named in brackets (the `[type-emoji]` error
  names the exact emoji), then retry. Never `git commit --no-verify`.

If a repo has no commitlint, the canonical mapping lives in
`~/.dotfiles/commitlint/commitlint.config.mjs`.
