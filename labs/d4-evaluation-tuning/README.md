<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Domain 4: Perform evaluation, error analysis, and tuning

Exam weight: 15–20%. Do the labs in order; later labs reuse earlier files.

| Lab | Time | Level |
| --- | --- | --- |
| [4A: Turn success criteria into automated signals](4a-turn-success-criteria-into-automated-signals/) | 35 min | Core |
| [4B: Build a repeatable evaluation set](4b-build-a-repeatable-evaluation-set/) | 50 min | Core |
| [4C: Diagnose failures from logs](4c-diagnose-failures-from-logs/) | 40 min | Core |
| [4D: Tune and prove it](4d-tune-and-prove-it/) | 40 min | Core |

## More practice

### Alternative lab on Azure

[Exercise 4: Evaluation, error analysis and tuning](https://github.com/sameeraman/gh-600-lab-instructions/blob/main/exercise-04-evaluation-and-tuning.md) (~25 min). Analysis exercise: diagnosing failures from logs and choosing the right tuning lever. Part of the community GH-600 lab guides by GitHub user sameeraman.

### Build it from scratch

Python labs from Ed Donner's open-source agent-engineering course (MIT licence), copied into [`labs/companion`](../companion) with credit. Background only: they use paid model APIs and don't cover Copilot.

- [Cyber-security agent (Semgrep MCP)](https://github.com/ed-donner/cyber): An agent that analyzes code through a Semgrep MCP server: automated scanning as an evaluation signal, delivered as an MCP tool.
- [Week 6 · Lab 5: observability, evaluation and feedback](../companion/agents/6_mcp/5_lab5.ipynb): Custom tracing plus an evaluation loop that feeds results back into the agent: error analysis and tuning in code.
- [Week 4 · Lab 5, Step 3: the evaluator](../companion/agents/4_langchain_langgraph/5_lab5.ipynb): An evaluator agent grades the worker against success criteria and sends it back.
- [Week 2 · Lab 3, Part 2: structured outputs](../companion/agents/2_openai/3_lab3.ipynb): Structured outputs make agent results machine-checkable, the basis of automated evaluation signals.
