# commitlint config

`@commitlint/config-conventional` with two deviations — a leading gitmoji enforced per
type, and subject-line only (a body/footer warns but doesn't block) — validating the
format described in the [`commit` skill](../agent/.config/agent/skills/commit/SKILL.md):

```
<emoji> <type>(<optional scope>): <subject>
```

commitlint configs are per-repo, so copy or symlink this into a project root:

```bash
ln -s ~/.dotfiles/commitlint/commitlint.config.mjs commitlint.config.mjs
pnpm add -D @commitlint/cli @commitlint/config-conventional
```

Run on every commit via husky:

```bash
pnpm add -D husky && pnpm exec husky init
echo 'pnpm exec commitlint --edit "$1"' > .husky/commit-msg
```

## Notes

- The `GITMOJI` map is the single source of truth: the parser regex, the `type-emoji`
  rule, and the prompt enum all derive from it, so `commitlint --print-config json`
  (`prompt.questions.type.enum.<type>.emoji`) is authoritative — agent docs point here
  rather than copying the table. Use canonical Unicode forms (e.g. `⚡️` includes U+FE0F).
- `🐛 feat:` fails `[type-emoji]`; an emoji not in the set fails to parse. A body or
  footer only warns (`[body-empty]`/`[footer-empty]`, severity 1) so auto-generated
  `git revert`/`merge` commits still pass. All other rules are upstream defaults.
- `.mjs` (not `.ts`) keeps the hook dependency-free; the `@type` JSDoc gives editor
  checking via `@commitlint/types`.
