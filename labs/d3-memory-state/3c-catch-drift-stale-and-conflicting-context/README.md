<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 3C: Catch drift, stale and conflicting context

**Domain 3: Manage memory, state, and execution** · 35 min · 4 steps

**Goal:** Create each context problem on purpose, detect it and fix it at the source.

**Exam skills you'll practise:** Detect and correct drift · Prevent conflicting context · Prevent stale context · Pruning and reset rules

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Conflict

**Conflict:** add `.github/instructions/tests.instructions.md` with `applyTo: "test/**"` and the rule "Use Jest". The repo-wide file says node:test. Ask the agent to add a test and watch it hesitate or pick one. Fix: delete the stale rule so there's one source of truth.

**What you should see:** The agent picks one framework or asks which to use. Fix: delete the Jest rule; rerun and it uses node:test without hesitation.

### Step 2: Drift

**Drift:** in a long CLI session, tell the agent early "never edit src/billing". Do ten unrelated small tasks, run `/compact`, then ask for a change that tempts it into billing ("make all money formatting consistent"). Check whether it remembers. Fix: put the rule in always-loaded instructions or tasks.md Decisions, and restate it.

**What you should see:** After compaction it may forget the billing rule. Fix by putting the rule in always-loaded instructions or tasks.md Decisions.

### Step 3: Stale

**Stale:** rename `dueSoon` to `dueWithin` in a branch. In a chat that still has the old code in history, ask for a feature using it. Note references to the old name. Fix: delete the stale turns or start a new chat for the new task.

**What you should see:** Code that calls `dueSoon` even though the branch only has `dueWithin`. A new chat fixes it.

### Step 4: Write a 3-line rule for each

Write a 3-line rule for each: how you'd detect it and how you'd prevent it.

**What you should see:** Three short rules, for example: "Drift: compare /diff to the plan's file list before each commit."

## Check your work

- [ ] You reproduced at least two of the three problems.
- [ ] Each fix removes or corrects the source of bad context, not just the symptom.

## Troubleshooting

- **Couldn't reproduce drift:** Make the session longer, or rely on compaction; drift shows up after summarization drops early constraints.

## Stretch goal

Use `/diff` before each commit as a drift check against the plan's file list.

## More practice

See [Domain 3: more practice](../README.md#more-practice).
