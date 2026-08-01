---
name: obsidian-plan
description: Use when planning a piece of work into my Obsidian vault, updating a plan's progress, or resuming from one. Plans belong in the vault, not in the repo or ~/.claude/plans. Includes a mandatory review gate before any plan is approved.
---

Read `~/.config/agent/skills/obsidian-notes/SKILL.md` for vault conventions and
`~/.config/agent/skills/obsidian-project/SKILL.md` for resolving which project and task you are in.
Do not duplicate that logic here.

## A plan is a status, not a shape

**A plan is not a kind of note.** There are only areas, projects, workstreams and tasks, and they all
have the same three sections. Approving a plan means writing its content into that structure — never
adding `Approach`, `Decisions`, `Review` or `Progress` headings, and never creating a standalone plan
note.

Where each part of a plan goes:

| Plan content | Lands in |
|---|---|
| Goal, and how the work is shaped | `## Summary` of the workstream or task |
| The actual work | `## Steps` on each task |
| Decisions, and the ones rejected | `## Notes`, at the level the decision applies to |
| Review findings | `## Notes` of whatever was reviewed |
| Progress narrative | `## Notes`, dated |

Plan a **task** when the work is one piece; a **workstream** when it spans several. If no suitable
note exists yet, create it via `obsidian-project` first, then plan into it.

**A workstream-sized plan creates its tasks at the same time.** The workstream carries the shared
summary; every unit of work becomes a task note from `Templates/Task.md` with `project`, `workstream`
and `order`. Create them all while saving the plan — deferring them leaves the workstream as one
opaque note, and a `type: note` standing in for the implementation detail is the standalone plan note
this rules out.

Do not restate the task list in the workstream's `## Summary`. The `## Tasks` block derives it, and a
hand-written copy drifts. Per-task detail like "done when the VM boots" belongs on that task.

**Name tasks for what they do** — `Bootstrap`, `Home Manager` — never `Phase 1 - …` or any other
ordering prefix. The type is already in frontmatter, and prefixes collide across workstreams. When
tasks are genuinely sequential, set `order: 0`, `order: 1` … and let the workstream's `## Tasks`
block sort on it. Ordering is data, not a filename: renumbering beats renaming, which would need the
CLI to keep links intact.

Status flow: `draft` while planning and under review → `todo` once the gate passes → `in-progress`
once work starts. Tasks start at `todo` alongside their workstream. **Revising a plan edits the same
notes.** Never create a second one.

Record real decisions in `## Notes`, including the ones *not* taken and why — that is the part worth
having in six months, since the steps will be obvious from the diff. Put each decision at the lowest
level it applies to, and surface it upward only if it affects siblings.

Keep it concise. When a decision's rationale runs long enough to bury what it explains, move it to a
sibling `type: note` and link out, leaving the headline inline. That is for rationale only — the
steps of a piece of work always live on its task, never on a note.

## The review gate

**No plan is approved without a subagent review pass.** The sequence is strict:

1. Draft the plan.
2. Francis reviews and comments. Iterate.
3. **Only once he says he is happy**, spawn the review subagent.

Never run it earlier. Reviewing a plan that is still churning wastes the pass, and its findings go
stale before he has finished commenting.

Use a read-only subagent (the `Plan` type), giving it every note being planned — the workstream and
all its tasks — and the repo it targets. It checks the plan **against reality**, not for style:

- Do the named files, functions and paths actually exist?
- Are the steps executable in the order given?
- Do any steps contradict each other?
- What does it assume without saying?
- Would the verification section actually catch a failure, or is it "look and see if it seems fine"?

Record the findings in `## Notes` on whatever was reviewed, along with what was done about each —
**including findings deliberately not acted on, and why**. Keep it to the findings that changed
something or that someone would otherwise hit again; a full transcript of the review helps nobody.

Report the findings to Francis. If any are material, the plan goes back to `draft` and the loop
repeats rather than being waved through. Only once the findings are resolved does `status` become
`todo`.

This is not ceremony. On the plan that built this vault the gate caught a note type that matched no
view, an embed that would have rendered one view instead of six, and CLI commands missing `vault=`
that could have written to the wrong vault.

Its blind spot is worth knowing: it checks whether a plan is *true*, not whether it fits these
conventions. It passed a plan whose tasks were all named `Phase N - …`, because nothing about naming
was wrong with respect to reality.

## Progress and resuming

Tick `## Steps` checkboxes as work proceeds, and add dated entries to `## Notes` saying what changed
and what is left. Statuses say what is active; the note says why and where you stopped. That is what
lets work be picked up mid-way on another machine, which is the entire reason plans live here.

When resuming, read the `## Notes` of the task and its workstream **before doing anything**, and
report where things stand. Do not restart from step one.

Record anything learned that contradicts the plan. A plan that turned out wrong is more useful
written down than quietly corrected.
