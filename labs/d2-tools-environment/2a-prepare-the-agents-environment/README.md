<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 2A: Prepare the agent's environment

**Domain 2: Implement tool use and environment interaction** · 25 min · 4 steps

**Goal:** Control what's installed before the coding agent starts.

**Exam skills you'll practise:** Evaluate execution context · Handle environment-specific constraints

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add the copilot-setup-steps.yml shown below and push it to main

Add the `copilot-setup-steps.yml` shown below and push it to `main`.

*From Example 2.1: Coding agent environment: copilot-setup-steps.yml*

**.github/workflows/copilot-setup-steps.yml**

```yaml
name: "Copilot Setup Steps"
on:
  workflow_dispatch:
  push:
    paths: [.github/workflows/copilot-setup-steps.yml]
  pull_request:
    paths: [.github/workflows/copilot-setup-steps.yml]

jobs:
  copilot-setup-steps:          # must be exactly this name
    runs-on: ubuntu-latest
    timeout-minutes: 15
    permissions:
      contents: read
    steps:
      - uses: actions/checkout@v6
      - uses: actions/setup-node@v7
        with:
          node-version: "20"
          cache: "npm"
      - run: npm ci
```

**What you should see:** The workflow file is on `main`.

**Terminal · commit and push**

```console
$ git add .
$ git commit -m "Add <what you added>"
$ git push
```

### Step 2: Open the Actions tab → Copilot Setup Steps → Run workflow

Open the Actions tab → **Copilot Setup Steps** → **Run workflow**. Confirm it passes.

**What you should see:** A green run named **Copilot Setup Steps** with one job, `copilot-setup-steps`, whose log shows `npm ci`.

### Step 3: Break it on purpose in a branch (change the job name to setup…

Break it on purpose in a branch (change the job name to `setup`) and open a PR. The path trigger runs it; note that the coding agent would no longer pick it up because the job name is wrong. Close the PR.

**What you should see:** The PR's checks run the workflow (path trigger). It may still pass, but the agent wouldn't use it because the job name is no longer `copilot-setup-steps`.

**Terminal**

```console
$ git checkout -b break-setup
# edit the job name to: setup
$ git commit -am "Rename setup job (test)"
$ git push -u origin break-setup
$ gh pr create --fill
```

### Step 4: Assign a small issue to Copilot and open View session

Assign a small issue to Copilot and open **View session**. Find your setup steps in the log before the agent starts work.

**What you should see:** In **View session**, the log starts with your setup steps (checkout, setup-node, npm ci) before the agent's first action.

## Check your work

- [ ] The workflow is on `main` with a job named `copilot-setup-steps`.
- [ ] The session log shows `npm ci` running before the agent's first action.

## Troubleshooting

- **Agent ignores the file:** It's not on the default branch, or the job name differs.
- **Need a private package registry:** Add the token as an **Agents** secret and reference it in a step's `env`; the agent can't read Actions secrets.

## Stretch goal

Add `services:` with a Postgres container and confirm the agent can reach it.

## More practice

See [Domain 2: more practice](../README.md#more-practice).
