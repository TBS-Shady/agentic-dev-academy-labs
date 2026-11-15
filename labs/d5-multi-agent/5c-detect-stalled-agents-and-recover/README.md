<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 5C: Detect stalled agents and recover

**Domain 5: Orchestrate multi-agent coordination** · 35 min · 5 steps

**Goal:** Make failed, partial and stalled agents visible and route them to a person.

**Exam skills you'll practise:** Identify failed, partial or stalled executions · Recovery patterns · Artifacts for review and audit

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add crew.yml shown below

Add `crew.yml` shown below. Run it from the Actions tab: all three agents pass and the summary lists each result.

*From Example 5.2: Fan-out, fan-in, timeouts and escalation in Actions*

**.github/workflows/crew.yml**

```yaml
name: Crew
on:
  pull_request:
  workflow_dispatch:
concurrency:
  group: crew-${{ github.head_ref || github.ref }}   # one run per PR/branch
  cancel-in-progress: true
permissions:
  contents: read
jobs:
  lint-agent:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - run: echo "lint findings: 0" > lint.txt
      - uses: actions/upload-artifact@v4
        with: { name: lint, path: lint.txt }

  test-agent:
    runs-on: ubuntu-latest
    timeout-minutes: 10
    steps:
      - uses: actions/checkout@v6
      - run: npm test > tests.txt 2>&1
      - uses: actions/upload-artifact@v4
        if: always()
        with: { name: tests, path: tests.txt }

  docs-agent:
    runs-on: ubuntu-latest
    timeout-minutes: 5
    steps:
      - run: sleep ${{ vars.DOCS_AGENT_DELAY || 1 }} && echo "docs ok" > docs.txt
      - uses: actions/upload-artifact@v4
        with: { name: docs, path: docs.txt }

  aggregate:
    needs: [lint-agent, test-agent, docs-agent]
    if: always()
    runs-on: ubuntu-latest
    steps:
      - uses: actions/download-artifact@v4
      - name: Summarize who did what
        run: |
          {
            echo "## Crew results"
            echo "- lint-agent: ${{ needs.lint-agent.result }}"
            echo "- test-agent: ${{ needs.test-agent.result }}"
            echo "- docs-agent: ${{ needs.docs-agent.result }}"
          } >> "$GITHUB_STEP_SUMMARY"
      - name: Escalate failed or stalled agents
        if: contains(needs.*.result, 'failure') || contains(needs.*.result, 'cancelled')
        run: |
          echo "::error::An agent failed or timed out. Human review needed."
          exit 1
```

**What you should see:** A green run. The aggregate job's **Summary** shows each agent's result.

**Job summary**

```text
## Crew results
- lint-agent: success
- test-agent: success
- docs-agent: success
```

### Step 2: Settings → Secrets and variables → Actions → Variables

Settings → Secrets and variables → Actions → Variables: add `DOCS_AGENT_DELAY = 400`. Re-run. docs-agent exceeds its 5-minute timeout, the aggregator still runs, and the escalation step fails the workflow with a clear message.

**What you should see:** docs-agent is cancelled after 5 minutes, aggregate still runs, and the escalation step fails with: *An agent failed or timed out. Human review needed.*

### Step 3: Break a test in a branch and open a PR

Break a test in a branch and open a PR. test-agent fails, but its output is still uploaded (`if: always()`). Download the artifact to see why.

**What you should see:** test-agent fails; the **tests** artifact still contains the failing output.

### Step 4: Push twice quickly to the same PR

Push twice quickly to the same PR: the first run is cancelled by the concurrency group. Push to a different PR at the same time: both run.

**What you should see:** The first run shows **Cancelled** with a note that a newer run in the same concurrency group started.

### Step 5: Delete the variable when done

Delete the variable when done.

**What you should see:** The variable is gone from Settings → Variables.

## Check your work

- [ ] A stalled agent became a visible failure with an escalation message.
- [ ] Partial results were preserved as artifacts.
- [ ] Concurrency serialized runs per PR only.

## Troubleshooting

- **Aggregator skipped:** It needs `if: always()`; otherwise a failed dependency skips it.

## Stretch goal

Replace the escalation step with one that opens an issue for a human using `gh issue create` (needs `issues: write`).

## More practice

See [Domain 5: more practice](../README.md#more-practice).
