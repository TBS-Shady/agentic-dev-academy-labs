<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 4D: Tune and prove it

**Domain 4: Perform evaluation, error analysis, and tuning** · 40 min · 5 steps

**Goal:** Apply the fix that matches each bucket and show the signal improved.

**Exam skills you'll practise:** Revise instructions, workflows or constraints · Refine memory usage · Refine tool usage and access

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Reasoning (T3 discount math)

Reasoning (T3 discount math): add a worked example to `billing.instructions.md`: *"1000¢ × 2, 10% discount, 10% tax → 1980¢"*. Re-run T3.

**What you should see:** T3 now applies the discount before tax and the test from the worked example passes.

### Step 2: Tool misuse

Tool misuse: create a custom agent whose tools exclude the misused tool, or tighten its instructions ("open files with read, not search"). Re-run.

**What you should see:** Re-run shows the misused tool isn't called.

### Step 3: Context

Context: fix the missing secret from 4c. Re-run.

**What you should see:** Start MCP Servers succeeds.

### Step 4: Scope

Scope: if T2 keeps touching other folders, move the constraint into the issue's Out-of-scope section and keep the scope check required.

**What you should see:** T2's PR touches only the allowed files and the scope check stays green.

### Step 5: Add the before/after rows to your scorecard

Add the before/after rows to your scorecard.

*From Example 4.2: A scorecard that mixes quantitative and qualitative signals*

**docs/agent-scorecard.md**

```markdown
| Run | Change tested            | Task | Tests pass | Regression test added | Out-of-scope files | CodeQL alerts | Reviewer (1–5) |
|-----|--------------------------|------|------------|-----------------------|--------------------|---------------|----------------|
| 1   | baseline                 | T1   | yes        | no                    | 0                  | 0             | 3              |
| 1   | baseline                 | T2   | no         | no                    | 2                  | 0             | 2              |
| 2   | +"regression test" rule  | T1   | yes        | yes                   | 0                  | 0             | 4              |
| 2   | +"regression test" rule  | T2   | yes        | yes                   | 2                  | 0             | 3              |
| 3   | +scope rule in issue     | T2   | yes        | yes                   | 0                  | 0             | 4              |
```

**What you should see:** Before/after rows in `docs/agent-scorecard.md`.

## Check your work

- [ ] Each fix matches its bucket.
- [ ] Each fix shows an improved signal in the scorecard.

## Troubleshooting

- **Fix didn't help:** Recheck the bucket. A reasoning fix can't solve an environment problem.

## Stretch goal

Revert one fix and confirm the signal drops again: the cleanest proof of cause.

## More practice

See [Domain 4: more practice](../README.md#more-practice).
