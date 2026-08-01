---
name: obsidian-project
description: Use when finding or creating a project, workstream or task in my Obsidian vault, or when updating the status of work. Covers how a repo maps to a project and how work is sized.
---

Read `~/.config/agent/skills/obsidian-notes/SKILL.md` first — it defines the vault structure,
frontmatter schema and file-operation rules. This skill covers only finding, creating and updating.

## Resolving the project

An explicitly named project always wins. Otherwise:

1. `git remote get-url origin`, normalised — strip the scheme, `git@`, and the trailing `.git`, so
   SSH and HTTPS clones of the same repo agree. Match against `remote:` in `Projects/*/`.
2. Repo with no `origin`: match the repo's directory name against project names.
3. Not in a repo, or no match: **ask**. Never guess.

One repo is one project, so this is unambiguous and works identically on any machine. **Never match
on filesystem path** — a repo can be cloned anywhere, and a work machine will not have the personal
ones at all, so a path fails precisely where portability is the point.

Reaching step 3 is normal, not a failure: sewing projects, D&D campaigns and reference notes have no
repo, and the `Obsidian vault` project deliberately has no remote.

## Resolving the task

A Jira key in the branch (`PROJ-101-rate-limiter`) resolves straight to that task. Otherwise ask
which task, or create one. Personal work happens on `main` with no key, so asking is the normal path
there — do not treat it as a problem to engineer around.

## Creating

**Project** — `Projects/<repo-name>/<repo-name>.md` from `Templates/Project.md`, named for the repo
**in the remote, not the directory** — `~/.local/share/chezmoi` with remote `…/dotfiles` becomes
`dotfiles`. Link it from its area note's `## Projects`.

For `area`: a work remote owner or a `~/dev/work/*` checkout means the employer area. Any other repo
is a personal *code* project — do not ask whether it belongs to a non-code area like `Sewing`, which
is never plausible for something with a git remote. Ask only when genuinely torn between two areas
that could both apply, or when there is no repo at all.

**Workstream** — only when enough tasks accumulate to need shared context, or immediately when Jira
already has an epic. It is optional; tasks attach directly to a project otherwise.

**Task** — from `Templates/Task.md`, carrying `project` and, if there is one, `workstream`.

Never hand-write a list of tasks anywhere. The Project and Workstream templates carry embedded base
blocks that derive their own contents.

## Sizing

Size the work *before* writing anything:

1. **A line in `Todos.md`** — trivial, or not yet attached to a project. Most small things stop here.
2. **A task note** — when it needs its own context, learnings, or a status worth resuming from.
3. **A task in `draft` with plan sections** — multi-step or with design decisions worth recording.
   That is the `obsidian-plan` skill.

Do not manufacture a task note for a one-line fix, and do not add a workstream for two tasks.
Promote between tiers when asked, or when the work turns out bigger than it looked.

## Updating status

Keep `status` current on the task and its project as work proceeds, and keep the project hub's
`**Next:**` line accurate — that line is what makes an interrupted project resumable from another
machine, and it is the first thing to go stale.

Set `blocked` as soon as work stalls on someone else. Unlike a "paused" state, you know the moment
it happens, which is why it is worth recording.

When resuming: read the hub note first, then the in-progress task, and **report where things stand
before doing any work**. Do not restart from the beginning of something already half done.
