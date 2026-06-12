---
name: commit
description: Use when creating a git commit or writing a commit message — the message convention (Conventional Commits + a leading gitmoji, subject line only), how to validate against commitlint, and the commit workflow. Does not push.
---

Write commits as Conventional Commits with a leading gitmoji, subject line only, validated
against commitlint before committing.

## Convention

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

### commitlint is the source of truth

Repos set up from `~/.dotfiles/commitlint` enforce this with a commit-msg hook. Don't
reproduce the rules — read them from the resolved config:

- Rules + the gitmoji for each type: `npx commitlint --print-config json`
  (emoji map under `prompt.questions.type.enum.<type>.emoji`, types under `type-enum`)
- Validate before committing: `printf '%s' "<message>" | npx commitlint` (exit 0 = valid)
- If a commit is rejected, fix only the rule named in brackets (the `[type-emoji]` error
  names the exact emoji), then retry. Never `git commit --no-verify`.

If a repo has no commitlint, the canonical mapping lives in
`~/.dotfiles/commitlint/commitlint.config.mjs`.

## Creating a commit

When asked to commit:

1. Run `git status --short` and `git diff HEAD` to see the current state.
2. If nothing is staged, stage the relevant changes yourself.
3. If the changes are unrelated, stop and propose splitting them into separate commits
   instead of committing them together.
4. Write the message per the convention above, validate against commitlint, then commit.
   Never push unless I explicitly ask.
