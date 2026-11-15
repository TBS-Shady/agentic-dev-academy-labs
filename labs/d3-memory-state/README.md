<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Domain 3: Manage memory, state, and execution

Exam weight: 10–15%. Do the labs in order; later labs reuse earlier files.

| Lab | Time | Level |
| --- | --- | --- |
| [3A: Choose the right memory for each fact](3a-choose-the-right-memory-for-each-fact/) | 30 min | Core |
| [3B: Interrupt and resume without repeating work](3b-interrupt-and-resume-without-repeating-work/) | 40 min | Core |
| [3C: Catch drift, stale and conflicting context](3c-catch-drift-stale-and-conflicting-context/) | 35 min | Core |
| [3D: Share state across jobs and tools](3d-share-state-across-jobs-and-tools/) | 30 min | Core |

## More practice

### Alternative lab on Azure

[Exercise 3: Memory, state and execution](https://github.com/sameeraman/gh-600-lab-instructions/blob/main/exercise-03-memory-state-execution.md) (~30 min). Analysis exercise: reading session state and memory behavior, no files created. Part of the community GH-600 lab guides by GitHub user sameeraman.

### Build it from scratch

Python labs from Ed Donner's open-source agent-engineering course (MIT licence), copied into [`labs/companion`](../companion) with credit. Background only: they use paid model APIs and don't cover Copilot.

- [Week 2 · Lab 1, Part 3: adding memory](../companion/agents/2_openai/1_lab1.ipynb): Short-term memory as conversation state.
- [Week 4 · Lab 2: graph memory and persisting to SQLite](../companion/agents/4_langchain_langgraph/2_lab2.ipynb): Why an agent forgets between runs and how checkpointing state lets it resume.
- [Week 6 · Lab 3: context engineering with MCP](../companion/agents/6_mcp/3_lab3.ipynb): Long-term memory and retrieval through MCP: external memory loaded on demand.
