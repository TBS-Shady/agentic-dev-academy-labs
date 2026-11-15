<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 4B: Build a repeatable evaluation set

**Domain 4: Perform evaluation, error analysis, and tuning** · 50 min · 5 steps

**Goal:** Grade agent changes against the same tasks every time.

**Exam skills you'll practise:** Qualitative and quantitative signals · Align evaluation with development intent

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Write three task files in eval/

Write three task files in `eval/`:

**eval/T1.md**

```text
Fix: dueSoon(days) must include tasks due exactly `days` from now. Add a regression test.
```

**eval/T2.md**

```text
Add GET /tasks?done=true|false using listTasks({ done }). Add tests. Do not change src/auth or src/billing.
```

**eval/T3.md**

```text
Add invoiceDiscount(lineItems, taxRate, discountPct) in src/billing/invoice.js. Discount applies before tax. Integer cents.
```

**What you should see:** Three files in `eval/`.

**Terminal · commit and push**

```console
$ git add .
$ git commit -m "Add <what you added>"
$ git push
```

### Step 2: Baseline run

Baseline run: for each file, `gh agent-task create -F eval/T1.md` (then T2, T3). Record a scorecard row per PR (format in Example 4.2). Close the PRs without merging.

**What you should see:** Three agent tasks and three draft PRs. One scorecard row each.

**Terminal**

```console
$ gh agent-task create -F eval/T1.md
$ gh agent-task create -F eval/T2.md
$ gh agent-task create -F eval/T3.md
$ gh agent-task list
```

### Step 3: Make one change

Make one change: add "Every change needs a regression test" to `copilot-instructions.md`. Re-run all three tasks and add rows.

**What you should see:** Three more PRs. Compare the **Regression test added** column with run 1.

### Step 4: Make a second, separate change (e.g

Make a second, separate change (e.g. add the Out-of-scope section to the task files). Re-run and add rows.

**What you should see:** Three more PRs. Compare the **Out-of-scope files** column.

### Step 5: Write two sentences

Write two sentences: which change moved which signal.

**What you should see:** Two sentences linking each change to the signal it moved.

## Check your work

- [ ] Scorecard has at least 9 rows across 3 runs.
- [ ] Each run differs from the previous one by exactly one change.

## Troubleshooting

- **Results vary run to run:** Agents are non-deterministic. Run each task twice per configuration and compare averages if results are noisy.

## Stretch goal

Script it: a workflow_dispatch job that starts the three tasks with gh agent-task and posts links to the job summary.

## More practice

See [Domain 4: more practice](../README.md#more-practice).
