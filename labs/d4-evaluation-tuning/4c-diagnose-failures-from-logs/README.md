<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 4C: Diagnose failures from logs

**Domain 4: Perform evaluation, error analysis, and tuning** · 40 min · 5 steps

**Goal:** Classify root causes from evidence, then confirm on real runs.

**Exam skills you'll practise:** Identify failures using logs, plans, traces, outputs and artifacts · Classify root causes

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Classify practice logs A–D (shown below)

Classify practice logs A–D (shown below). Write the bucket and the fix for each before reading the takeaway.

*From Example 4.3: Practice logs: classify the root cause*

**Log A**

```text
[tool] search_code {"query": "src/tasks.js"} → 0 results
[tool] search_code {"query": "src/tasks.js"} → 0 results
[agent] dueSoon not found; creating src/utils.js with a new dueSoon()
```

**Log B**

```text
[tool] read src/billing/invoice.js → ok
[agent] Discount applies after tax: total = round(subtotal*(1+tax)) * (1-discount) * (1+tax)
[tool] bash npm test → 1 failing: expected 1980, received 2178
```

**Log C**

```text
[setup] Start MCP Servers: sentry → error 401 Unauthorized
[agent] Could not fetch issue details; guessing the stack trace from the title
```

**Log D**

```text
[setup] copilot-setup-steps › npm ci → ECONNREFUSED npm.internal.example
[tool] bash npm test → Error: Cannot find module 'pg'
```

**What you should see:** A: tool misuse. B: reasoning error. C and D: context/environment.

### Step 2: Create a real environment failure

Create a real environment failure: in the MCP configuration, reference a secret that doesn't exist (`$COPILOT_MCP_MISSING`) for one server. Run a task and find the error under **Start MCP Servers**.

**What you should see:** The **Start MCP Servers** step shows an error for that server, and the agent continues without its tools.

### Step 3: Create a real context failure

Create a real context failure: start a task with `--base` pointing at an old branch that lacks `dueSoon`. Read how the agent reacts in the log.

**What you should see:** The log shows the agent searching for `dueSoon` and not finding it, then working around it or reporting the problem.

### Step 4: Investigate a finished run without re-running it

Investigate a finished run without re-running it: `gh run download <run-id>` for its artifacts and read the session log from the PR's **View session**.

**What you should see:**

**Terminal**

```console
$ gh run list --limit 5
$ gh run download <run-id>
```

### Step 5: For each real failure, write

For each real failure, write: bucket, evidence line, fix, and how you'll verify the fix.

**What you should see:** One line per failure: bucket · evidence · fix · how you'll verify.

## Check your work

- [ ] Practice answers: A tool misuse, B reasoning, C and D context/environment.
- [ ] Each real failure has a quoted log line as evidence.

## Troubleshooting

- **Agent quietly worked around the failure:** That's itself a finding: add an instruction to stop and report missing tools or credentials instead of guessing.

## Stretch goal

Add an `errorOccurred` hook (Domain 6) that writes failures to a log so they're easy to find.

## More practice

See [Domain 4: more practice](../README.md#more-practice).
