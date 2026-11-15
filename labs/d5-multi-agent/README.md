<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Domain 5: Orchestrate multi-agent coordination

Exam weight: 15–20%. Do the labs in order; later labs reuse earlier files.

| Lab | Time | Level |
| --- | --- | --- |
| [5A: Build a crew with subagents and handoffs](5a-build-a-crew-with-subagents-and-handoffs/) | 45 min | Core |
| [5B: Run agents in parallel and resolve conflicts](5b-run-agents-in-parallel-and-resolve-conflicts/) | 50 min | Core |
| [5C: Detect stalled agents and recover](5c-detect-stalled-agents-and-recover/) | 35 min | Core |
| [5D: Manage agent lifecycle and do a post-hoc review](5d-manage-agent-lifecycle-and-do-a-post-hoc-review/) | 35 min | Core |

## More practice

### Alternative lab on Azure

[Exercise 5: Multi-agent orchestration](https://github.com/sameeraman/gh-600-lab-instructions/blob/main/exercise-05-multi-agent-orchestration.md) (~45 min). Parallel agent reviews in ci.yml with a matrix of custom agents (copilot --agent=NAME), consolidated through workflow artifacts. Part of the community GH-600 lab guides by GitHub user sameeraman.

### Build it from scratch

Python labs from Ed Donner's open-source agent-engineering course (MIT licence), copied into [`labs/companion`](../companion) with credit. Background only: they use paid model APIs and don't cover Copilot.

- [Alex: multi-agent SaaS capstone](../companion/alex): A production-style multi-agent financial planner with each agent as its own project, deployed with Terraform. Shows how a crew of agents is structured and shipped.
- [Week 2 · Lab 2: orchestration by code vs. by LLM](../companion/agents/2_openai/2_lab2.ipynb): The two ways to coordinate agents: fixed code flow (assembly line) or an LLM manager deciding who does what.
- [Week 2 · Lab 4: deep research](../companion/agents/2_openai/4_lab4.ipynb): Planner, search and writer agents: a manager-and-crew pattern with fan-out searches.
- [Week 4 · Lab 4: deep agents and sub-agents](../companion/agents/4_langchain_langgraph/4_lab4.ipynb): Sub-agent delegation with focused context, plus agent skills.
- [CrewAI: engineering team](../companion/agents/3_crewai/reference/engineering_team): A crew of role agents (lead, backend, frontend, test) building code together.
- [Week 5 · Day 5: the agent loop](../companion/agents/5_agent_frameworks/5_agent_loop/lab.md): An orchestrator agent runs five workers in parallel on a shared board, checks their work and sends failures back for repair: parallel execution, conflict avoidance and recovery.
