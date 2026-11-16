<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 3A: Choose the right memory for each fact

**Domain 3: Manage memory, state, and execution** · 30 min · 5 steps

**Goal:** Place information in short-term, long-term or external memory and measure the context cost.

**Exam skills you'll practise:** Choose short-term, long-term, external memory · Scope memory to task-relevant information

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Start copilot in agent-lab and run /context

Start `copilot` in agent-lab and run `/context`. Note the size of instructions and tools.

**What you should see:** A breakdown of the context window. Your numbers will differ:

**Copilot CLI · example**

```console
> /context
  System prompt        ███
  Instructions         █
  Tools                ██████
  Messages             ██
  Free space           ████████████████████
```

### Step 2: Paste the whole runbook into the instructions file and compare the context

Temporarily paste the whole runbook into `.github/copilot-instructions.md`, restart, and run `/context` again. Note the increase.

**What you should see:** The **Instructions** segment grows noticeably.

### Step 3: Revert that change

Revert that change. Create the `release-runbook` skill shown below. Restart and check `/context`: the runbook no longer costs space.

*From Example 3.1: Always-loaded vs. on-demand: moving a runbook into a skill*

**.github/skills/release-runbook/SKILL.md**

```markdown
---
name: release-runbook
description: Steps to cut a release of agent-lab. Use when asked to release, tag, version or publish.
---
Follow docs/release-runbook.md step by step.
Before tagging, run `npm test` and stop if anything fails.
Record each completed step as a checked box in the PR description.
```

**Layout**

```text
.github/skills/release-runbook/
├── SKILL.md
└── (optional scripts the skill can run)
Personal skills: ~/.copilot/skills/<name>/SKILL.md
```

**What you should see:** Instructions shrink back. The runbook now lives in `.github/skills/release-runbook/SKILL.md`.

### Step 4: Ask for the release steps and confirm the skill loads

Ask *"What are the steps to cut a release?"* and confirm the skill loads (the CLI shows skill usage). Then ask an unrelated question and confirm it doesn't load.

**What you should see:** For the release question, the CLI shows it used the `release-runbook` skill. For an unrelated question it doesn't.

### Step 5: Sort the facts into short-term, long-term and external memory

Sort these into short-term / long-term / external, and write the answers in `docs/memory-map.md`: "use integer cents", "the bug I'm fixing right now", "Node.js API reference", "we chose node:test over Jest", "today's failing test output".

**What you should see:** Your memory map: conventions and decisions → long-term; API reference → external; the bug in progress and today's test output → short-term.

## Check your work

- [ ] You measured a smaller context with the skill than with the pasted runbook.
- [ ] Your memory map puts conventions and decisions in long-term, reference docs in external, and in-progress details in short-term.

## Troubleshooting

- **Skill never loads:** The `description` must say when to use it; the folder must contain `SKILL.md`; name in lowercase-hyphens.

## Stretch goal

Enable Copilot Memory (personal settings, or the org Memory policy) and see which repository facts it stores and their citations.

## More practice

See [Domain 3: more practice](../README.md#more-practice).
