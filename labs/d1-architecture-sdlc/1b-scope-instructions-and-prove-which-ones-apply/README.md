<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 1B: Scope instructions and prove which ones apply

**Domain 1: Prepare agent architecture and SDLC processes** · 30 min · 5 steps

**Goal:** Know exactly which instruction file reaches which request.

**Exam skills you'll practise:** Define inputs, outputs and success criteria · Inspectable artifacts

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add the three files from the "Repository, path and cross-agen…

Add the three files from the "Repository, path and cross-agent instructions" example and push to `main`.

*From Example 1.2: Repository, path and cross-agent instructions*

**.github/copilot-instructions.md**

```markdown
# agent-lab conventions (applies to every Copilot request in this repo)
- Node.js 20, CommonJS, built-in modules only. Ask before adding a dependency.
- Run tests with `npm test`. Every bug fix needs a regression test in `test/`.
- Compare dates with getTime(); never compare Date objects with ==.
- Never read or modify files in `customer-data/`.
```

**.github/instructions/billing.instructions.md**

```markdown
---
applyTo: "src/billing/**"
---
- Money is integer cents. Never use floating point for stored amounts.
- Every exported function needs a JSDoc block with units.
```

**AGENTS.md**

```markdown
# Notes for any AI coding agent
Build: none. Test: `npm test`. Entry point: `src/server.js`.
High-risk folders: `src/auth/` (security review required), `src/billing/`.
```

**What you should see:** Three new files pushed to `main`.

**Terminal · commit and push**

```console
$ git add .
$ git commit -m "Add <what you added>"
$ git push
```

### Step 2: In VS Code Copilot Chat (Agent mode), ask

In VS Code Copilot Chat (Agent mode), ask: *"Add a function in src/billing/invoice.js that applies a percentage discount."* Expand the response's **References** and confirm both `copilot-instructions.md` and `billing.instructions.md` were used.

**What you should see:** Copilot's answer has a collapsible **References** list near the top. It should list `copilot-instructions.md` and `billing.instructions.md`.

> **If something's off:** In VS Code, open Copilot Chat (<kbd>Ctrl</kbd>+<kbd>Alt</kbd>+<kbd>I</kbd>), choose **Agent** in the mode picker, and make sure the agent-lab folder is open.

### Step 3: Ask

Ask: *"Add a function in src/tasks.js that counts overdue tasks."* Confirm only the repo-wide file is referenced, not the billing one.

**What you should see:** References list only `copilot-instructions.md`. The billing file doesn't apply because `src/tasks.js` isn't under `src/billing/**`.

### Step 4: Check the billing result

Check the billing result: amounts stay in integer cents and there's a JSDoc block. If not, tighten the wording of the rule and retry.

**What you should see:** The billing function works in integer cents (no `0.1 * price` left as a float) and has a `/** … */` JSDoc block.

### Step 5: Discard the changes (git checkout .)

Discard the changes (`git checkout .`).

**What you should see:**

**Terminal**

```console
$ git checkout .
$ git status
On branch main
nothing to commit, working tree clean
```

## Check your work

- [ ] Billing request references both files; tasks request references only the repo-wide file.
- [ ] The billing function follows the cents and JSDoc rules.

## Troubleshooting

- **Instructions not referenced:** Check that instruction files are enabled in VS Code's Copilot chat settings, and that the files sit in `.github/` with the exact names shown.

## Stretch goal

Add `excludeAgent: "code-review"` to the billing file's frontmatter and see that Copilot code review no longer uses it.

## More practice

See [Domain 1: more practice](../README.md#more-practice).
