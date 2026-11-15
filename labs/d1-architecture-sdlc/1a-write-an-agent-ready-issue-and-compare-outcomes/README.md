<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 1A: Write an agent-ready issue and compare outcomes

**Domain 1: Prepare agent architecture and SDLC processes** · 40 min · 5 steps

**Goal:** See for yourself how much the input drives the agent's output.

**Exam skills you'll practise:** Define inputs, outputs and success criteria · Identify and mitigate anti-patterns

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add an issue form so every agent task starts with the right f…

Add an issue form so every agent task starts with the right fields.

**.github/ISSUE_TEMPLATE/agent-task.yml**

```yaml
name: Agent task
description: A task scoped for Copilot coding agent
title: "[agent] "
labels: ["agent-task"]
body:
  - type: textarea
    id: context
    attributes:
      label: Context
      description: What happens today? Name the files involved.
    validations:
      required: true
  - type: textarea
    id: expected
    attributes:
      label: Expected behavior
    validations:
      required: true
  - type: textarea
    id: repro
    attributes:
      label: Steps to reproduce
  - type: textarea
    id: acceptance
    attributes:
      label: Acceptance criteria
      value: |
        - [ ] npm test passes
        - [ ] New regression test
        - [ ] No changes outside the listed files
    validations:
      required: true
  - type: textarea
    id: out-of-scope
    attributes:
      label: Out of scope
```

Commit and push it to `main`.

**What you should see:** The file is on `main`. On GitHub, **Issues → New issue** now offers an **Agent task** form with Context, Expected behavior, Steps to reproduce, Acceptance criteria and Out of scope.

**Terminal · commit and push**

```console
$ git add .
$ git commit -m "Add <what you added>"
$ git push
```

> **If something's off:** If the form doesn't appear, the file must be in `.github/ISSUE_TEMPLATE/` on the default branch, with a `.yml` extension and valid YAML (indentation matters).

### Step 2: Create the vague issue

Create the **vague** issue: title "dueSoon is broken", body "Some tasks don't show up." Assign it to **Copilot** (Assignees → Copilot).

**What you should see:** Within a minute Copilot reacts with 👀 on the issue, and the timeline shows *Copilot started work* with a link to a draft pull request.

> **If something's off:** Use **New issue → Blank issue** for the vague version. If Copilot isn't in Assignees, the cloud agent isn't enabled for your account or org.

### Step 3: Wait for the draft PR

Wait for the draft PR. Note: which files changed, whether a test was added, whether the boundary bug was found.

**What you should see:** A draft PR titled something like *Fix dueSoon…*. Open **Files changed**. With only "dueSoon is broken" to go on, agents often change unrelated code or miss the boundary case, and may not add a test.

> **If something's off:** If checks don't run, click **Approve and run workflows** on the PR; workflows on Copilot's pushes wait for approval by default. Results vary run to run, so don't worry if your first PR looks different.

### Step 4: Close that PR without merging

Close that PR without merging. Create a new issue from the **Agent task** form using the agent-ready text shown below (Example 1.1). Assign it to Copilot.

*From Example 1.1: An agent-ready issue vs. a vague one*

**Vague issue**

```text
Title: dueSoon is broken
Body: Some tasks don't show up. Please fix.
```

**Agent-ready issue**

```markdown
Title: dueSoon() misses tasks due exactly N days out

## Context
`src/tasks.js` → `dueSoon(days, now)` returns open tasks due within `days`.
A task due exactly 1 day from `now` is not returned by `dueSoon(1, now)`.

## Expected
Tasks due at or before `now + days` are included (inclusive boundary).

## Steps to reproduce
1. `addTask("x", "2026-01-02T00:00:00Z")`
2. `dueSoon(1, new Date("2026-01-01T00:00:00Z"))` → returns `[]`, expected 1 task.

## Acceptance criteria
- [ ] Boundary case returns the task
- [ ] New regression test in `test/tasks.test.js`
- [ ] `npm test` passes
- [ ] No changes outside `src/tasks.js` and `test/`

## Out of scope
Server routes, billing, auth.
```

**What you should see:** A second draft PR. This time the description should mention the boundary case and a new test. Locally, the new test fails on the old code and passes on the fixed code:

**Terminal · real output: the new boundary test fails before the fix**

```console
$ npm test
✔ invoiceTotal adds tax (0.7ms)
✔ addTask requires a title (1.2ms)
✔ completeTask marks a task done (0.2ms)
✔ dueSoon finds a task due tomorrow (0.2ms)
✖ dueSoon includes a task due exactly N days out (0.5ms)
ℹ tests 5
ℹ pass 4
ℹ fail 1

✖ failing tests:
test at test/tasks.test.js:22:1
  AssertionError [ERR_ASSERTION]: 0 == 1
```

**Terminal · real output after the agent's fix (< changed to <=)**

```console
$ npm test
✔ invoiceTotal adds tax (0.8ms)
✔ addTask requires a title (1.4ms)
✔ completeTask marks a task done (0.2ms)
✔ dueSoon finds a task due tomorrow (0.2ms)
✔ dueSoon includes a task due exactly N days out (0.2ms)
ℹ tests 5
ℹ pass 5
ℹ fail 0
```

> **If something's off:** To try the PR locally: `gh pr checkout <number>` then `npm test`. Return with `git checkout main`.

### Step 5: Compare the two PRs side by side in a short table

Compare the two PRs side by side in a short table: files changed, test added (Y/N), bug fixed (Y/N), unrelated changes (Y/N).

**What you should see:** A short table, for example:

**docs/issue-comparison.md**

```markdown
| PR      | Files changed            | Test added | Bug fixed | Unrelated changes |
|---------|--------------------------|------------|-----------|-------------------|
| Vague   | src/tasks.js, server.js  | No         | Partly    | Yes               |
| Ready   | src/tasks.js, test/      | Yes        | Yes       | No                |
```

> **If something's off:** The point to write down: which issue field (repro steps, acceptance criteria, out of scope) prevented which mistake.

## Check your work

- [ ] The agent-ready PR changes `<` to `<=` (or equivalent) and adds a boundary test.
- [ ] The agent-ready PR touches only `src/tasks.js` and `test/`.
- [ ] You can name which issue field prevented which mistake.

## Troubleshooting

- **Copilot isn't in the Assignees list:** The cloud agent isn't enabled for your account or org, or the repo is excluded. Check Settings → Copilot → Cloud agent (or ask your admin).
- **PR has no checks running:** Workflows on Copilot's pushes wait for approval. Click **Approve and run workflows** on the PR.

## Stretch goal

Add a `config.yml` to the template folder with `blank_issues_enabled: false` so every issue uses a form.

## More practice

See [Domain 1: more practice](../README.md#more-practice).
