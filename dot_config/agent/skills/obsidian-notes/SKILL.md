---
name: obsidian-notes
description: Use when reading or writing notes in my personal Obsidian vault — the folder structure, frontmatter conventions, naming, and Obsidian-flavoured Markdown. Read by the obsidian-project and obsidian-plan skills.
---

The personal vault is `~/Documents/francis-notes/francis`. **If it does not exist, say so and stop.**
Do not create it — it is absent on work machines, and a fake vault produces notes that never sync.
The shared vault (`~/Documents/shared-notes/shared-notes`) is out of scope.

## Structure

```
Areas/         ongoing groupings that never finish — one per employer or life domain
Projects/      one folder per repo, or per non-code endeavour
  <project>/
    <project>.md               hub note, named for the folder
    <workstream>.md            optional grouping of tasks
    <task>.md                  a unit of work
    <note>.md                  your own understanding of something
Resources/     external material tied to no project
Templates/     start here rather than inventing a note shape
Attachments/
Todos.md       the only place loose todos live
Dashboard.md   Projects / Board / Stale views, plus Todos
Active.base    the view definitions
```

**A project is a repo.** Non-code projects (a quilt, a D&D campaign) are projects without a remote.
Two folder levels, never three. Nothing is ever moved or archived — `status: done` plus the Bases
filters do the hiding.

**Where a note goes:** a repo file if someone cloning the repo needs it (README, ADR); a vault note
in the project folder if it is your own understanding (onboarding notes, why a service is odd);
`Resources/` if it is external material tied to no project.

## Frontmatter

One `status` vocabulary for every type: `draft` → `todo` → `in-progress` → `blocked` → `done` /
`cancelled`. There is no `paused` — the Stale view derives that from `file.mtime` instead.

| Type | Properties |
|---|---|
| `area` | `status` |
| `project` | `status`, `area` (link), `remote` |
| `workstream` | `status`, `project` (link), `url` |
| `task` | `status`, `project` (link), `workstream` (link), `url`, `order` |
| `note` | `project` (link), `source` |

`remote` is the normalised git origin — `github.com/Francis-Gurr/dotfiles`, scheme and `.git`
stripped. **Never a filesystem path**: paths differ per machine and would fail exactly where
portability matters. Omit it for non-code projects.

`area`, `project`, `workstream` are links and need quoting: `area: "[[Personal dev]]"`. `type` and
`status` stay plain strings — they are schema enums, not concepts, and linking them would create
empty stub notes. `url` is work-only, pointing at Jira.

`project` is set on a task even when `workstream` is too. Mild duplication, but it lets Bases group
by project without following a link it cannot traverse.

`order` is an integer, set only when a workstream's tasks run in sequence. It exists so ordering
never ends up in a filename: `Phase 1 - Bootstrap` collides across workstreams, repeats the `type`
already in frontmatter, and needs a CLI rename to reorder.

**Leave optional properties present but blank rather than deleting them** — `order`, `url`,
`workstream` on an unattached task. A note should carry the same keys its template does, so the
properties panel prompts you with the field instead of relying on you remembering it exists. Bases
treats blank and absent identically, so this is for your benefit, not the queries'.

## Writing notes

- **No `# H1`.** Obsidian renders the filename as an inline title, so a matching H1 shows twice.
  Start at `##`.
- **One line per paragraph**, no hard wrapping at a fixed column.
- Sentence case with spaces (`Setup rust lsp.md`); work notes lead with the Jira key. A project
  folder matches its hub note and the repo name from the remote — so `dotfiles`, not `chezmoi`.
- `[[wikilinks]]` for anything in the vault, Markdown links for external URLs only.
- Checkboxes in a task are its `## Steps` — sub-parts of that work. Only `Todos.md` holds todos;
  projects and workstreams have no checkbox section at all.
- Lists of tasks are **derived, never written by hand** — an embedded ` ```base ` block filtered on
  `workstream == this` cannot drift, because the table is the frontmatter.

Obsidian syntax worth knowing: `[[Note#Heading]]`, `[[Note|display]]`, `![[Note]]` to embed,
`![[Active.base#View]]` to embed one view of a base, `> [!note]` callouts, `==highlight==`,
`%%comment%%`.

## File operations

**Create and edit** with normal file tools — Obsidian watches the filesystem, so this works headless
and over SSH.

**Rename, move and delete** must go through the CLI, because Obsidian only rewrites inbound
wikilinks when the operation goes through it. An external `mv` reads as delete-plus-create and
silently orphans every link.

```
obsidian vault="francis" rename file=<name> name=<new>
obsidian vault="francis" move   file=<name> to=<path>
obsidian vault="francis" delete file=<name>
```

`vault="francis"` is **mandatory** — both vaults are open at once, and without it a rename can hit
the shared one. Never `mv` or `rm` a note. If the CLI is unavailable, say what needs renaming and
leave it; a deferred rename beats silently broken links.

`.obsidian/*.json` is the exception to all of the above: the running app holds config in memory and
overwrites those files on exit, so they can only be edited with Obsidian closed. Anything needed
while it is running has to go through Settings instead.
