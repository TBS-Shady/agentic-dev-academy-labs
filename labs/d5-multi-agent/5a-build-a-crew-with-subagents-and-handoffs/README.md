<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 5A: Build a crew with subagents and handoffs

**Domain 5: Orchestrate multi-agent coordination** · 45 min · 5 steps

**Goal:** Apply the manager and assembly-line patterns with explicit checkpoints.

**Exam skills you'll practise:** Apply an orchestration pattern · Document handoffs · Human-in-the-loop recovery

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add the four agent files from the crew example and open VS Code

Add the four agent files from the crew example and open VS Code. Confirm planner, implementer and reviewer appear in the agents dropdown and researcher doesn't.

*From Example 5.1: A small crew: planner → implementer → reviewer, with a hidden researcher*

**.github/agents/planner.agent.md**

```markdown
---
name: planner
description: Produces an implementation plan for a task. Never edits files.
tools: ["read", "search", "agent"]
agents: ["researcher"]
handoffs:
  - label: Implement this plan
    agent: implementer
    prompt: Implement the plan above. Keep tasks.md updated as you go.
    send: false
---
Write a numbered plan: files to change, tests to add, out-of-scope folders, risks.
Delegate Node.js API questions to the researcher subagent.
```

**.github/agents/researcher.agent.md**

```markdown
---
name: researcher
description: Looks up Node.js and GitHub API details and returns a short cited answer.
tools: ["read", "search", "web"]
user-invocable: false
---
Answer in five bullets or fewer, each with a source link.
```

**.github/agents/implementer.agent.md**

```markdown
---
name: implementer
description: Implements an approved plan and runs the tests.
tools: ["read", "search", "edit", "execute"]
handoffs:
  - label: Review the changes
    agent: reviewer
    prompt: Review the changes against the plan and the acceptance criteria.
    send: false
---
Follow the plan exactly. Stop and ask if the plan is wrong.
```

**.github/agents/reviewer.agent.md**

```markdown
---
name: reviewer
description: Reviews changes against the plan. Read-only.
tools: ["read", "search"]
---
List any deviation from the plan, missing tests, or out-of-scope edits.
```

**What you should see:** The agents dropdown in VS Code chat lists planner, implementer and reviewer. researcher is hidden.

**Terminal · commit and push**

```console
$ git add .
$ git commit -m "Add <what you added>"
$ git push
```

### Step 2: Select planner

Select **planner**: *"Plan GET /tasks?done=true|false."* Watch it delegate a question to the researcher subagent (it appears as a subagent run in the chat).

**What you should see:** The chat shows a nested *subagent* run (researcher) inside planner's response, then the plan.

### Step 3: Click Implement this plan

Click **Implement this plan**. The prompt is pre-filled but not sent (`send: false`). Edit it if needed, then send.

**What you should see:** Clicking the button switches to implementer with the prompt pre-filled in the input box, waiting for you to send it.

### Step 4: After implementation, click Review the changes

After implementation, click **Review the changes**. Fix anything the reviewer flags.

**What you should see:** The reviewer lists deviations or confirms the change matches the plan.

### Step 5: Break it to learn the rules

Break it to learn the rules: remove `"agent"` from planner's tools and ask again. The researcher can't be called. Restore it.

**What you should see:** Planner answers itself or says it can't delegate. Put `agent` back in its tools.

## Check your work

- [ ] Researcher is hidden but callable.
- [ ] Both handoffs waited for you before sending.
- [ ] Without the agent tool, delegation stopped working.

## Troubleshooting

- **Handoff button missing:** The `agent:` value must match the target's name (or file name if no name is set).

## Stretch goal

Set `disable-model-invocation: true` on researcher and confirm the planner can still call it because it's listed in `agents`.

## More practice

See [Domain 5: more practice](../README.md#more-practice).
