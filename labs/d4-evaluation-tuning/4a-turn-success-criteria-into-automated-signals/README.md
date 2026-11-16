<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 4A: Turn success criteria into automated signals

**Domain 4: Perform evaluation, error analysis, and tuning** · 35 min · 5 steps

**Goal:** Make "done" checkable by machines before a person reviews.

**Exam skills you'll practise:** Specify outcomes and constraints · Generate signals with automated scanning · Align criteria with intent

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add agent-pr-checks.yml shown below and push to main

Add `agent-pr-checks.yml` shown below and push to `main`.

*From Example 4.1: Automated evaluation signals on every agent PR*

**.github/workflows/agent-pr-checks.yml**

```yaml
name: Agent PR checks
on: pull_request
permissions:
  contents: read
jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
      - uses: actions/setup-node@v7
        with: { node-version: "20" }
      - run: npm test

  scope:
    if: startsWith(github.head_ref, 'copilot/')
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v6
        with: { fetch-depth: 0 }
      - name: Fail if the agent touched protected folders
        run: |
          changed=$(git diff --name-only "origin/${{ github.base_ref }}...HEAD")
          echo "$changed"
          if echo "$changed" | grep -E '^(src/auth/|customer-data/)'; then
            echo "::error::Agent PR changes a protected folder"; exit 1
          fi

  codeql:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      security-events: write
    steps:
      - uses: actions/checkout@v6
      - uses: github/codeql-action/init@v4
        with: { languages: javascript-typescript }
      - uses: github/codeql-action/analyze@v4
```

**What you should see:** The workflow file is on `main`.

**Terminal · commit and push**

```console
$ git add .
$ git commit -m "Add <what you added>"
$ git push
```

### Step 2: Settings → Code security

Settings → Code security: enable **secret scanning** and **push protection** (free on public repos; private repos need GitHub Secret Protection / Code Security).

**What you should see:** Both toggles are on under Settings → Code security.

> **If something's off:** On a private repo these may require GitHub Secret Protection / Code Security. Making agent-lab public is fine: it holds no real data.

### Step 3: Assign the agent-ready dueSoon issue (Lab 1a) to Copilot

Assign the agent-ready dueSoon issue (Lab 1a) to Copilot. Approve workflows. Confirm test, scope and CodeQL checks all report on the PR.

**What you should see:** Three checks on the PR: **test**, **scope** and **codeql**, all green.

### Step 4: Create an issue that tempts the agent into a protected folder

Create an issue that tempts the agent into a protected folder: *"Let task owners delete their own tasks; update the auth check."* Assign it, and confirm the **scope** job fails on the resulting PR.

**What you should see:** The **scope** check fails:

**Actions log · scope job**

```console
src/auth/session.js
src/server.js
Error: Agent PR changes a protected folder
```

### Step 5: Map each acceptance criterion to the check that proves it

Map each acceptance-criteria line in your issue template to the check that proves it. Any line without a check is a qualitative signal for the reviewer.

**What you should see:** A two-column list: acceptance criterion → check that proves it.

## Check your work

- [ ] Three checks appear on agent PRs.
- [ ] The scope job fails when `src/auth/` changes on a `copilot/` branch.
- [ ] You have a criteria → signal mapping.

## Troubleshooting

- **CodeQL fails with permissions:** The job needs `security-events: write`.
- **Scope job didn't run:** It only runs when the head branch starts with `copilot/`.

## Stretch goal

Make the checks required with a ruleset (Lab 6c) so an agent can't merge around them.

## More practice

See [Domain 4: more practice](../README.md#more-practice).
