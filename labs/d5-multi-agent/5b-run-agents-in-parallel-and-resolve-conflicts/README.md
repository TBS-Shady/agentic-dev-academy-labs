<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 5B: Run agents in parallel and resolve conflicts

**Domain 5: Orchestrate multi-agent coordination** · 50 min · 6 steps

**Goal:** Isolate parallel agents and catch overlapping changes and contradictory outputs before merge.

**Exam skills you'll practise:** Configure agent isolation · Detect and resolve conflicts

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Create a ruleset on main requiring the test check and Require…

Create a ruleset on `main` requiring the **test** check and **Require branches to be up to date before merging** (Settings → Rules → Rulesets).

**What you should see:** Settings → Rules → Rulesets shows an active ruleset targeting the default branch.

> **If something's off:** Add the **test** status check from Lab 4a. It appears in the picker after it has run at least once.

### Step 2: Create two issues and assign both to Copilot at the same time

Create two issues and assign both to Copilot at the same time: (1) *"Rename dueSoon to dueWithin everywhere."* (2) *"Add a test that dueSoon ignores completed tasks."*

**What you should see:** Two draft PRs from two different `copilot/` branches, working at the same time.

### Step 3: Each runs on its own copilot/ branch (isolation)

Each runs on its own `copilot/` branch (isolation). Merge PR 1 first.

**What you should see:** PR 1 merged into main.

### Step 4: PR 2 is now out of date

PR 2 is now out of date. Update it with main: its new test calls `dueSoon`, which no longer exists, so the required test check fails. That's a contradictory output caught before merge.

**What you should see:** After **Update branch**, PR 2's test check fails:

**Actions log · test job (example)**

```console
✖ dueSoon ignores completed tasks
  TypeError: t.dueSoon is not a function
ℹ fail 1
```

### Step 5: Comment on PR 2

Comment on PR 2: `@copilot merge main into this branch and update the new test to use dueWithin`. Confirm the check goes green, then merge.

**What you should see:** Copilot pushes a fix, the check turns green, and the merge button becomes available.

### Step 6: Write down which control caught each conflict type

Write down which control caught each conflict type: overlapping edits (git conflict), contradictory outputs (required checks on an up-to-date branch), duplicated effort (issue triage before assigning).

**What you should see:** Three lines matching each conflict type to the control that caught it.

## Check your work

- [ ] Both agents worked in parallel on separate branches.
- [ ] The broken combination never reached main.

## Troubleshooting

- **No conflict appeared:** Make sure PR 2 was updated with main after PR 1 merged; the up-to-date rule forces it.

## Stretch goal

Use a concurrency group on the crew workflow and explain why that would be wrong if both agents must run concurrently.

## More practice

See [Domain 5: more practice](../README.md#more-practice).
