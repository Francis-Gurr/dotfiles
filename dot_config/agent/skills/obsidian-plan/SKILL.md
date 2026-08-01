---
name: obsidian-plan
description: Use when planning a piece of work into my Obsidian vault, updating a plan's progress, or resuming from one. Plans belong in the vault, not in the repo or ~/.claude/plans. Includes a mandatory review gate before any plan is approved.
---

Read `~/.config/agent/skills/obsidian-notes/SKILL.md` for vault conventions and
`~/.config/agent/skills/obsidian-project/SKILL.md` for resolving which project and task you are in.
Do not duplicate that logic here.

## A plan is a status, not a note

**Never create a separate plan note.** A plan is an existing task or workstream moved to
`status: draft`, with these sections added to its body:

```markdown
## Approach
## Decisions
## Review
## Progress
```

Plan a **task** when the work is one piece; a **workstream** when it spans several tasks. If no
suitable note exists yet, create it via `obsidian-project` first, then plan into it. Templates stay
lean deliberately — these sections appear only when work is genuinely planned, so a one-line fix
never opens with four empty headings.

Status flow: `draft` while planning and under review → `todo` once the gate passes → `in-progress`
once work starts. **Revising a plan edits the same note.** Never create a second one.

Keep plans focused. When a rationale runs beyond a short paragraph, move it to a sibling
`type: note` in the same project folder and link out, leaving the headline decision inline.

Record real decisions under `## Decisions`, including the ones *not* taken and why. That is the part
worth having in six months; the steps will be obvious from the diff.

## The review gate

**No plan is approved without a subagent review pass.** The sequence is strict:

1. Draft the plan.
2. Francis reviews and comments. Iterate.
3. **Only once he says he is happy**, spawn the review subagent.

Never run it earlier. Reviewing a plan that is still churning wastes the pass, and its findings go
stale before he has finished commenting.

Use a read-only subagent (the `Plan` type), giving it the note being planned and the repo it
targets. It checks the plan **against reality**, not for style:

- Do the named files, functions and paths actually exist?
- Are the steps executable in the order given?
- Do any steps contradict each other?
- What does it assume without saying?
- Would the verification section actually catch a failure, or is it "look and see if it seems fine"?

Record the findings under `## Review` along with what was done about each — **including findings
deliberately not acted on, and why**. That record is the reason the section exists.

Report the findings to Francis. If any are material, the plan goes back to `draft` and the loop
repeats rather than being waved through. Only once `## Review` is filled and the findings are
resolved does `status` become `todo`. **An empty `## Review` means the gate has not run.**

This is not ceremony. On the plan that built this vault the gate caught a note type that matched no
view, an embed that would have rendered one view instead of six, and CLI commands missing `vault=`
that could have written to the wrong vault.

## Progress and resuming

Tick `## Steps` checkboxes and keep `## Progress` current as work proceeds — dated entries, saying
what changed and what is left. That is what lets the work be picked up mid-way on another machine,
which is the entire reason plans live here.

When resuming, read `## Progress` **before doing anything** and report where things stand. Do not
restart from step one.

Record in `## Progress` anything learned that contradicts the plan. A plan that turned out wrong is
more useful written down than quietly corrected.
