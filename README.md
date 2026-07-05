# dotfiles

My personal dotfiles, managed with [chezmoi](https://chezmoi.io). Cross-platform:
**macOS, Fedora, Ubuntu/Debian**.

## Bootstrap a new machine

One command installs chezmoi, clones this repo, prompts a couple of questions, and applies
everything:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply Francis-Gurr
```

What it does, in order:

1. **Prompt** — `is_work?` (and, if yes, your work git email).
2. **Install packages** — per OS: `dnf` + the `scottames/ghostty` COPR on Fedora, `apt` on
   Debian/Ubuntu, Homebrew (incl. the ghostty cask) on macOS. Also installs starship.
3. **GitHub auth** — `gh auth login` over SSH (generates/uploads a key), sets `git_protocol ssh`,
   and repoints this repo's remote to SSH.
4. **Externals** — fetches the zsh plugins and the FiraCode Nerd Font (over HTTPS).
5. **Default shell** — switches your login shell to zsh.
6. **commitlint** — installs pnpm + a Node runtime and enables the commit-msg hook in this repo.
7. **Font cache** — `fc-cache` on Linux.

Steps 2, 3 and 5 are interactive (sudo password / browser login).

## Day-to-day

The source tree lives at `~/.local/share/chezmoi` (`chezmoi cd` to jump there).

```sh
chezmoi edit ~/.zshrc      # edit the source for a file
chezmoi apply              # apply pending changes to $HOME
chezmoi diff               # preview what apply would change
chezmoi add ~/.config/foo  # start tracking a new file
chezmoi re-add             # pull edits made directly in $HOME back into the source
chezmoi update             # git pull + apply
```

## Adding a tool

1. Track its config: `chezmoi add ~/.config/<tool>/...`
2. Add its package name(s) to `.chezmoidata.yaml` (`common`, or a per-OS list if the name differs).
   For anything needing a special install (a repo, cask, or script), edit
   `run_onchange_before_10-packages.sh.tmpl`.
3. Commit and push.

## git identity

Personal (`francis.gurr@gmail.com`) is the default. Repos under `~/dev/work/` use the work email via
an `includeIf` in `~/.gitconfig` that pulls in `~/.config/git/work.inc` (only materialized on
machines answered as "work" during init). Keep personal projects in `~/dev/*`, work in `~/dev/work/*`.

## Layout notes

- **Managed**: git, zsh, ghostty, tmux, lazygit, neovim. tmux plugins and nvim-lspconfig are vendored
  via `.chezmoiexternal.toml.tmpl`; nvim's other plugins are managed by Neovim's native `vim.pack`.
- **Kept but not yet ported**: `agent/` and `ttyper/` are still in the old stow layout and listed in
  `.chezmoiignore`, so chezmoi does not apply them yet (agent needs `~/.claude` symlinks; ttyper is
  cargo-only). They'll be migrated incrementally.
- **Parked**: the Wayland desktop stack (sway/waybar/greetd/fuzzel), wezterm, and Arch (`pacman`)
  support live on the [`arch`](https://github.com/Francis-Gurr/dotfiles/tree/arch) branch, to be
  ported back into `main` if a Linux desktop is adopted.

## Commits

Conventional Commits with a leading gitmoji (e.g. `✨ feat(zsh): …`, `🐛 fix(git): …`), enforced by
commitlint via the commit-msg hook. See `commitlint/`.
