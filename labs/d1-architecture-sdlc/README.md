<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Domain 1: Prepare agent architecture and SDLC processes

Exam weight: 15–20%. Do the labs in order; later labs reuse earlier files.

| Lab | Time | Level |
| --- | --- | --- |
| [1A: Write an agent-ready issue and compare outcomes](1a-write-an-agent-ready-issue-and-compare-outcomes/) | 40 min | Core |
| [1B: Scope instructions and prove which ones apply](1b-scope-instructions-and-prove-which-ones-apply/) | 30 min | Core |
| [1C: Plan first: approve before any change](1c-plan-first-approve-before-any-change/) | 35 min | Core |
| [1D: Run the full loop and set checkpoints by risk](1d-run-the-full-loop-and-set-checkpoints-by-risk/) | 45 min | Core |

## More practice

### Alternative lab on Azure

[Exercise 1: Prepare agent architecture](https://github.com/sameeraman/gh-600-lab-instructions/blob/main/exercise-01-agent-architecture.md) (~15 min). Writes repository-wide instructions for a real React + ASP.NET Core app. Part of the community GH-600 lab guides by GitHub user sameeraman.

### Build it from scratch

Python labs from Ed Donner's open-source agent-engineering course (MIT licence), copied into [`labs/companion`](../companion) with credit. Background only: they use paid model APIs and don't cover Copilot.

- [Week 2 · Lab 1: agent loop, tools and traces](../companion/agents/2_openai/1_lab1.ipynb): Build a minimal agent loop and read its trace. The trace is the from-scratch version of the inspectable artifacts (plans, logs) Domain 1 asks for.
- [Week 4 · Lab 5, Step 2: human-in-the-loop middleware](../companion/agents/4_langchain_langgraph/5_lab5.ipynb): Pause an agent for human approval before it acts. Same idea as plan approval and checkpoints by risk.
- [CrewAI reference projects: AGENTS.md](../companion/agents/3_crewai/reference/engineering_team/AGENTS.md): Real AGENTS.md files: instructions written for any coding agent (Lab 1B).
