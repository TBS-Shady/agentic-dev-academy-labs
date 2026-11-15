<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 1C: Plan first: approve before any change

**Domain 1: Prepare agent architecture and SDLC processes** · 35 min · 6 steps

**Goal:** Separate planning from execution and validate a plan.

**Exam skills you'll practise:** Configure planning distinct from execution · Output a structured plan · Validate plans · Prevent action until approved

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: In the repo folder run copilot

In the repo folder run `copilot`. Press <kbd>Shift</kbd>+<kbd>Tab</kbd> until the mode shows **plan** (or type `/plan`).

**What you should see:** The CLI's status line shows the current mode. Each <kbd>Shift</kbd>+<kbd>Tab</kbd> cycles modes until it reads **plan**.

**Terminal**

```console
$ cd agent-lab
$ copilot
```

> **If something's off:** First run asks you to trust the folder and sign in. Choose to trust this folder only.

### Step 2: Prompt

Prompt: *"Add a priority filter to listTasks and support GET /tasks?priority=high."*

**What you should see:** Copilot reads the code, asks clarifying questions if needed, and writes a plan. It doesn't change files yet.

### Step 3: Before approving, run git status in another terminal

Before approving, run `git status` in another terminal. It should show no changes.

**What you should see:**

**Terminal · second window**

```console
$ git status
On branch main
nothing to commit, working tree clean
```

> **If something's off:** If files have changed, you weren't in plan mode. Discard with `git checkout .` and start again.

### Step 4: Review the plan against the "structured plan" example

Review the plan against the "structured plan" example: are files, tests and out-of-scope folders listed? Does it notice that `server.js` matches `req.url` exactly? If not, reply with the correction and ask for a revised plan.

*From Example 1.3: A structured plan you can validate*

**plan.md (what a good plan looks like)**

```markdown
# Plan: priority filter for GET /tasks
1. src/tasks.js: listTasks({ done, priority }) filters by priority when given.
2. src/server.js: parse ?priority= from the URL and pass it through.
3. test/tasks.test.js: tests for priority filter, and for no filter (unchanged).
Files NOT touched: src/auth/**, src/billing/**
Risks: URL parsing for "/tasks?priority=high" (current code matches the exact path).
Done when: npm test passes; GET /tasks still returns all tasks.
```

**What you should see:** Compare the plan to this good example. Ask for a revision if it misses the files list, the tests or the URL-parsing risk.

### Step 5: Approve

Approve. Let it implement, then run `npm test` and `curl "localhost:3000/tasks?priority=high"` with the server running (`npm start`).

**What you should see:** Tests pass and the filtered endpoint returns only high-priority tasks.

**Terminal · example output**

```console
$ npm start            # in one window
http://localhost:3000

$ curl -s -X POST localhost:3000/tasks -d '{"title":"ship","priority":"high"}'
$ curl -s "localhost:3000/tasks?priority=high"
[{"id":1,"title":"ship","dueDate":null,"priority":"high","done":false}]
```

> **If something's off:** PowerShell users: use `curl.exe` instead of `curl`, or test in the browser at `http://localhost:3000/tasks?priority=high`.

### Step 6: Repeat the same prompt in VS Code using the built-in Plan age…

Repeat the same prompt in VS Code using the built-in **Plan** agent, then hand off to implementation. Note the difference: VS Code shows a handoff button instead of an approval prompt.

**What you should see:** VS Code's **Plan** agent produces the plan in chat and offers a button to start implementation. That button is a handoff.

## Check your work

- [ ] No file changed before approval.
- [ ] The final change includes the URL parsing fix and tests.
- [ ] You changed at least one thing in the plan before approving.

## Troubleshooting

- **Plan mode not offered:** Update the CLI (`npm install -g @github/copilot`) — plan mode needs a recent version.

## Stretch goal

Write a short `.github/prompts/plan-feature.prompt.md` prompt file that asks for plans in the format above, and invoke it with `/plan-feature` in VS Code chat.

## More practice

See [Domain 1: more practice](../README.md#more-practice).
