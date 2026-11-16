<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 5D: Manage agent lifecycle and do a post-hoc review

**Domain 5: Orchestrate multi-agent coordination** · 35 min · 5 steps

**Goal:** Add, update and retire agents without disrupting work, and reconstruct what happened later.

**Exam skills you'll practise:** Add, update, replace and retire agents · Post-hoc analysis · Document decisions and handoffs

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add the agent registry file, docs/agents.md

Add `docs/agents.md` from the registry example in the same PR as any agent change from now on.

*From Example 5.3: An agent registry for lifecycle and audit*

**docs/agents.md**

```markdown
| Agent       | Purpose                 | Tools                         | Owner     | Status   | Added      | Retired    |
|-------------|-------------------------|-------------------------------|-----------|----------|------------|------------|
| planner     | Plans tasks             | read, search, agent           | @you      | active   | 2026-11-14 |            |
| researcher  | Cited API lookups       | read, search, web             | @you      | active   | 2026-11-14 |            |
| implementer | Implements plans        | read, search, edit, execute   | @you      | active   | 2026-11-14 |            |
| reviewer    | Read-only review        | read, search                  | @you      | active   | 2026-11-14 |            |
| docs-agent  | Old docs updater        | read, edit                    | @you      | retired  | 2026-10-01 | 2026-11-20 |
```

**What you should see:** `docs/agents.md` on main.

### Step 2: Add

**Add:** create `test-writer.agent.md` (tools: read, search, edit, execute) and add it to implementer's `agents` list, by PR.

**What you should see:** test-writer appears in the registry and implementer's `agents` list, both in one PR.

### Step 3: Update

**Update:** while an agent task is running, merge a PR that changes reviewer's instructions. The running task keeps the version it started with; the next task uses the new one.

**What you should see:** The running task finishes with the old instructions; the next one follows the new ones.

### Step 4: Retire

**Retire:** remove researcher from planner's `agents`, delete or archive its file, and mark it retired in the registry, all in one PR. Confirm its earlier runs are still visible in PR timelines.

**What you should see:** researcher is gone from dropdowns and callers; its old runs still show in PR timelines.

### Step 5: Post-hoc

**Post-hoc:** pick one PR from Lab 5b and write a five-line timeline: which agent did what, when, which handoff or comment triggered it, and the evidence link for each line.

**What you should see:** Five lines, each ending with a link to a PR event, session log or artifact.

## Check your work

- [ ] Every agent change landed through a PR with a registry update.
- [ ] Your timeline cites session logs, PR events or artifacts for every line.

## Troubleshooting

- **Lost history of a retired agent:** Never force-push or rewrite history; retire by adding commits.

## Stretch goal

Replace reviewer with reviewer-v2 using a handoff target change, keeping v1 available until in-flight work finishes.

## More practice

See [Domain 5: more practice](../README.md#more-practice).
