<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Domain 6: Implement guardrails and accountability

Exam weight: 10–15%. Do the labs in order; later labs reuse earlier files.

| Lab | Time | Level |
| --- | --- | --- |
| [6A: Block destructive actions with hooks](6a-block-destructive-actions-with-hooks/) | 40 min | Core |
| [6B: Right-size permissions](6b-right-size-permissions/) | 35 min | Core |
| [6C: Gate merges and sensitive paths](6c-gate-merges-and-sensitive-paths/) | 35 min | Core |
| [6D: Production approvals, exclusions and the audit trail](6d-production-approvals-exclusions-and-the-audit/) | 40 min | Org admin |

## More practice

### Alternative lab on Azure

[Exercise 6: Guardrails and accountability](https://github.com/sameeraman/gh-600-lab-instructions/blob/main/exercise-06-guardrails-and-accountability.md) (~35 min). preToolUse policy hooks that deny pushes to main, force pushes, secrets in commands and recursive deletes, plus a post-edit audit hook. Part of the community GH-600 lab guides by GitHub user sameeraman.

> **Note:** One change worth making: the lab's hook script ends by printing `{"permissionDecision": "allow"}` for every other command, which auto-approves every tool that isn't blocked. Print nothing instead, so normal permission prompts still apply (see Example 6.1).

### Build it from scratch

Python labs from Ed Donner's open-source agent-engineering course (MIT licence), copied into [`labs/companion`](../companion) with credit. Background only: they use paid model APIs and don't cover Copilot.

- [Week 2 · Lab 3, Part 3: guardrails](../companion/agents/2_openai/3_lab3.ipynb): Input and output guardrails that stop an agent run when a rule is broken: the code-level cousin of preToolUse hooks.
- [Week 4 · Lab 5, Step 2: approve before acting](../companion/agents/4_langchain_langgraph/5_lab5.ipynb): Human approval for chosen tool calls, with options to approve, edit or reject.
- [Week 2 · Lab 3, optional: sandbox agents](../companion/agents/2_openai/3_lab3.ipynb): Running agent work in a sandbox so mistakes can't spread.
