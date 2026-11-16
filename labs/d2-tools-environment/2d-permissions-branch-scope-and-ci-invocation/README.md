<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 2D: Permissions, branch scope and CI invocation

**Domain 2: Implement tool use and environment interaction** · 45 min · 4 steps

**Goal:** Scope the agent's actions locally and in CI, and start agent tasks on a chosen branch.

**Exam skills you'll practise:** Branch-based scope · Invoke an agent in CI · Retries, rollbacks, escalation · Traceability

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Run Copilot CLI with one tool allowed and one denied

Run `copilot --allow-tool='shell(npm test)' --deny-tool='shell(git push)'`. Ask it to run the tests (no prompt), then to commit (prompt), then to push (blocked). Record each outcome.

**What you should see:** Three different outcomes:

**Copilot CLI · example**

```console
$ copilot --allow-tool='shell(npm test)' --deny-tool='shell(git push)'
> run the tests
  ● shell: npm test          ← runs, no prompt
> commit the changes
  ? Allow shell: git commit -am "…"?  [y/N]   ← asks
> push to origin
  ✖ shell: git push  denied by --deny-tool    ← blocked
```

### Step 2: Create a release/1.0 branch and push it

Create a `release/1.0` branch and push it. Start an agent task on it:

**terminal**

```bash
gh agent-task create "Add a CHANGELOG.md with a 1.0.0 entry" --base release/1.0 --follow
```

Confirm the `copilot/` branch and PR target `release/1.0`.

**What you should see:** A PR whose base is `release/1.0`, from a branch named `copilot/…`.

**Terminal**

```console
$ git checkout -b release/1.0 && git push -u origin release/1.0
$ gh agent-task create "Add a CHANGELOG.md with a 1.0.0 entry" --base release/1.0 --follow
```

### Step 3: Run the agent from CI

Run the agent from CI. In an **organization-owned** repo you don't need a PAT: give the job `permissions: copilot-requests: write` and set `COPILOT_GITHUB_TOKEN: ${{ github.token }}` (the org's "Copilot CLI billed to the organization" policy must be on). In a personal repo, create a fine-grained PAT with the **Copilot Requests** permission and save it as Actions secret `COPILOT_PAT`, as below:

**.github/workflows/agent-test-report.yml**

```yaml
name: Agent test report
on: workflow_dispatch
permissions:
  contents: read
jobs:
  report:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      - uses: actions/setup-node@v7
        with: { node-version: "20" }
      - run: npm install -g @github/copilot
      - name: Ask Copilot for a test report
        env:
          COPILOT_GITHUB_TOKEN: ${{ secrets.COPILOT_PAT }}
        run: |
          copilot -p "Run npm test and write a short report of results to report.md" \
            --allow-tool='shell(npm test)' --allow-tool=write --no-ask-user
          cat report.md >> "$GITHUB_STEP_SUMMARY"
      - uses: actions/upload-artifact@v4
        with:
          name: agent-report-${{ github.run_id }}-${{ github.sha }}
          path: report.md
```

Run it and read the job summary.

**What you should see:** A green run whose **Summary** tab shows the report, plus an artifact named `agent-report-<run_id>-<sha>`.

> **If something's off:** Actions → Agent test report → Run workflow.

### Step 4: Failure-path design

Failure-path design: write in `docs/agent-error-handling.md` what the agent should do for (a) a flaky test timeout, (b) a merged change that broke main, (c) a missing permission. Use: retry with backoff and a cap → escalate; revert PR → re-run CI; stop and hand off to a person.

**What you should see:** A short doc with three rows: what triggers it, what the agent does, who gets involved.

## Check your work

- [ ] Push was blocked even though you allowed other tools.
- [ ] The release task's PR targets `release/1.0`.
- [ ] The CI run has a summary and an artifact named with run_id and sha.

## Troubleshooting

- **CI step fails to authenticate:** With a PAT: it needs the Copilot Requests permission. With GITHUB_TOKEN: the job needs `copilot-requests: write`, the repo must be org-owned, and the org policy allowing Copilot CLI billed to the organization must be enabled.

## Stretch goal

Make the CI job read-only by removing `--allow-tool=write` and printing the report to stdout instead.

## More practice

See [Domain 2: more practice](../README.md#more-practice).
