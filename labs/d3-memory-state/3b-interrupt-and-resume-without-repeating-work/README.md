<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 3B: Interrupt and resume without repeating work

**Domain 3: Manage memory, state, and execution** · 40 min · 5 steps

**Goal:** Persist progress and decisions as durable artifacts and resume from them.

**Exam skills you'll practise:** Capture progress and decisions as durable artifacts · Resume work without repeating steps

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: In copilot, start

In `copilot`, start: *"Implement a priority filter (low|normal|high). Keep a tasks.md file with Decisions and a Progress checklist; update it after every step and commit."*

*From Example 3.2: Durable progress: a tasks.md the agent keeps*

**tasks.md**

```markdown
# Task: priority filter (issue #12)
Decisions
- Priority values: low | normal | high (decided 2026-11-14, keep)
- Do NOT touch src/billing/** (from plan approval)

Progress
- [x] listTasks accepts { priority }        (commit 3f2a1c9)
- [x] server parses ?priority=               (commit 8b77e02)
- [ ] tests for priority filter
- [ ] README section
Verify: npm test → 0 failures
```

**What you should see:** A `tasks.md` with Decisions and a Progress checklist appears, and commits follow each step.

### Step 2: After two boxes are checked, quit the CLI (Ctrl+C twice)

After two boxes are checked, quit the CLI (<kbd>Ctrl</kbd>+<kbd>C</kbd> twice).

**What you should see:** The session ends. `tasks.md` shows two checked boxes.

### Step 3: Start a fresh session (copilot, then /clear to be sure)

Start a fresh session (`copilot`, then `/clear` to be sure). Prompt: *"Resume the work in tasks.md. Don't redo checked items. Follow the Decisions section."*

**What you should see:** The new session reads `tasks.md` and starts at the first unchecked item.

### Step 4: Check the git log

Check the git log: no step repeated, no decision reversed.

**What you should see:**

**Terminal · example**

```console
$ git log --oneline
9c1e0aa Add tests for priority filter        ← resumed session
8b77e02 Parse ?priority= in server           ← first session
3f2a1c9 listTasks accepts { priority }       ← first session
```

### Step 5: Do the same with the coding agent

Do the same with the coding agent: on an open Copilot PR, comment `@copilot please continue from the checklist in the PR description`. Compare with unassigning/reassigning the issue (which restarts from the issue).

**What you should see:** @copilot continues on the same branch; reassigning the issue starts a new PR from scratch.

## Check your work

- [ ] The resumed session's first commit continues from the first unchecked box.
- [ ] You can explain when to use @copilot on the PR vs. reassigning the issue.

## Troubleshooting

- **Agent starts over anyway:** Your resume prompt must point at the artifact; the new session has no memory of the old one.

## Stretch goal

Use `copilot --resume` (or `--continue`) to reopen the previous local session and compare with resuming from tasks.md alone.

## More practice

See [Domain 3: more practice](../README.md#more-practice).
