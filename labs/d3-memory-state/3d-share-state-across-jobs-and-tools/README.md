<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 3D: Share state across jobs and tools

**Domain 3: Manage memory, state, and execution** · 30 min · 4 steps

**Goal:** Move agent outputs between workflow jobs and make them reviewable later.

**Exam skills you'll practise:** Share agent state · Continuity across tools and environments

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add the plan-then-act.yml excerpt shown below (add an on

Add the `plan-then-act.yml` excerpt shown below (add an `on: workflow_dispatch` trigger and a `name`).

*From Example 3.4: Passing state between workflow jobs*

**.github/workflows/plan-then-act.yml (excerpt)**

```yaml
jobs:
  plan:
    runs-on: ubuntu-latest
    outputs:
      risk: ${{ steps.classify.outputs.risk }}
    steps:
      - id: classify
        run: echo "risk=low" >> "$GITHUB_OUTPUT"
      - run: echo "# plan" > plan.md
      - uses: actions/upload-artifact@v4
        with: { name: plan, path: plan.md }
  act:
    needs: plan
    if: needs.plan.outputs.risk == 'low'
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
        with: { name: plan }
      - run: cat plan.md
```

**What you should see:** The workflow file is on `main`.

**Terminal · commit and push**

```console
$ git add .
$ git commit -m "Add <what you added>"
$ git push
```

### Step 2: Run it

Run it. Confirm the `act` job reads `plan.md` from the artifact and only runs when risk is low.

**What you should see:** Both jobs green. The act job's log prints the contents of `plan.md`.

### Step 3: Change the classify step to risk=high and re-run

Change the classify step to `risk=high` and re-run: `act` is skipped.

**What you should see:** plan is green; act shows as **skipped**.

### Step 4: Download the plan artifact from the run page

Download the plan artifact from the run page. This is the same evidence path Domain 4 uses for post-hoc analysis.

**What you should see:** A `plan.zip` download from the run's **Artifacts** section.

## Check your work

- [ ] The second job got the file via artifact and the value via job output.
- [ ] Changing the output changes which jobs run.

## Troubleshooting

- **Output is empty:** The step needs an `id`, and the job must map it under `outputs:`. Multi-line values need delimiter syntax.

## Stretch goal

Gate the act job on a protected environment with a required reviewer when risk is high (preview of Domain 6).

## More practice

See [Domain 3: more practice](../README.md#more-practice).
