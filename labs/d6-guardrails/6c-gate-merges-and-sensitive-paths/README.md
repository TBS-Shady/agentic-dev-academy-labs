<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 6C: Gate merges and sensitive paths

**Domain 6: Implement guardrails and accountability** · 35 min · 5 steps

**Goal:** Require the right human approval only where risk is real.

**Exam skills you'll practise:** Identify actions requiring human judgment · Minimize approvals that don't reduce risk

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add the CODEOWNERS file (use your own username) and the ruleset shown below

Add the CODEOWNERS file (use your own username) and the ruleset shown below.

*From Example 6.3: Who must approve what: CODEOWNERS + ruleset + environment*

**.github/CODEOWNERS**

```text
# Security reviews anything touching auth or workflows
/src/auth/            @your-username
/.github/workflows/   @your-username
/.github/hooks/       @your-username
```

**Ruleset on main (Settings → Rules → Rulesets)**

```text
Target: default branch          Enforcement: Active
☑ Restrict deletions            ☑ Block force pushes
☑ Require a pull request        Required approvals: 1
   ☑ Require review from Code Owners
☑ Require status checks: test, scope, CodeQL
   ☑ Require branches to be up to date
Bypass list: (empty — add a single trusted bot only if a real exception exists)
```

**.github/workflows/deploy.yml (excerpt)**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production   # required reviewer + "Prevent self-review"
    steps:
      - run: echo "deploying ${{ github.sha }}"
```

**What you should see:** CODEOWNERS on main and an active ruleset.

### Step 2: Assign Copilot an issue that changes src/tasks.js

Assign Copilot an issue that changes `src/tasks.js`. One approval + green checks lets it merge.

**What you should see:** One approval and green checks: merge enabled.

### Step 3: Assign an issue that changes src/auth/session.js

Assign an issue that changes `src/auth/session.js`. The PR now needs a code owner's approval in addition. (The scope check from Lab 4a also blocks it unless you relax it for a labeled PR.)

**What you should see:** The PR shows *Review required: code owner* until you approve as the code owner.

### Step 4: Try to push directly to main from the CLI agent

Try to push directly to main from the CLI agent: blocked by the ruleset.

**What you should see:**

**Terminal · example**

```console
$ git push origin main
remote: error: GH013: Repository rule violations found for refs/heads/main.
remote: - Changes must be made through a pull request.
 ! [remote rejected] main -> main (push declined due to repository rule violations)
```

### Step 5: Approval balance

Approval balance: list every approval now in your process and mark each "reduces real risk" or "doesn't". Remove one that doesn't.

**What you should see:** A list of approvals with one removed and a sentence on why.

## Check your work

- [ ] Auth changes need a code owner; tasks changes don't.
- [ ] Direct pushes and force pushes to main fail.

## Troubleshooting

- **Can't approve your own PR:** Copilot authors agent PRs, so you can approve them. For PRs you author, add a second account or test in an org.

## Stretch goal

If one automation legitimately needs to skip a rule, add only that app/bot as a bypass actor instead of weakening the rule for everyone.

## More practice

See [Domain 6: more practice](../README.md#more-practice).
