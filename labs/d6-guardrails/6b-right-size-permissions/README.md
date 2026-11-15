<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 6B: Right-size permissions

**Domain 6: Implement guardrails and accountability** · 35 min · 5 steps

**Goal:** Give every agent and workflow the least privilege that works.

**Exam skills you'll practise:** Scope permissions and execution contexts for least privilege

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add the agent-triage.yml excerpt (trigger on

Add the `agent-triage.yml` excerpt (trigger `on: issues: types: [opened]`). Open an issue and confirm the label is added.

*From Example 6.2: Least-privilege workflow permissions*

**.github/workflows/agent-triage.yml (excerpt)**

```yaml
permissions:
  contents: read          # default for every job
jobs:
  analyze:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      - run: npm test
  label:
    needs: analyze
    runs-on: ubuntu-latest
    permissions:
      issues: write       # only this job can write, and only to issues
    steps:
      - run: gh issue edit ${{ github.event.issue.number }} --add-label triaged
        env:
          GH_TOKEN: ${{ github.token }}
          GH_REPO: ${{ github.repository }}
```

**What you should see:** New issues get the **triaged** label automatically.

> **If something's off:** Create the label first: Issues → Labels → New label → *triaged*.

### Step 2: Move issues

Move `issues: write` from the job to the workflow level and remove the job-level block: it still works, but now every job can write. Move it back.

**What you should see:** Still works, but every job now holds write access. Move it back.

### Step 3: Remove issues

Remove `issues: write` entirely: the label step fails with 403. That's least privilege working.

**What you should see:** The label step fails:

**Actions log · label job**

```console
HTTP 403: Resource not accessible by integration
```

### Step 4: Narrow CLI grants

Narrow CLI grants: compare `--allow-tool='shell(git)'` with `--allow-tool='shell(git log)'`. Ask for history (both fine), then a push (only the first would allow it without a deny rule).

**What you should see:** With `shell(git)` a push isn't blocked; with `shell(git log)` it prompts.

### Step 5: Review the fine-grained PAT from Lab 2b

Review the fine-grained PAT from Lab 2b: one repository, read-only. Write down what an attacker could do with it if it leaked.

**What you should see:** One sentence on the blast radius of your PAT.

## Check your work

- [ ] Only the label job holds a write permission.
- [ ] You can explain why shell(git) is broader than it looks.

## Troubleshooting

- **gh fails with 'could not determine repo':** Set `GH_REPO` as shown, or check out the repo first.

## Stretch goal

Use `--available-tools` to hide web tools entirely for a local session and confirm the agent can't fetch URLs.

## More practice

See [Domain 6: more practice](../README.md#more-practice).
