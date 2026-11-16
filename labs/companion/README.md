<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Companion code

Open-source agent-engineering labs used as optional background in each domain's **More practice** section. They build agents from scratch in Python with paid model APIs; they don't cover GitHub Copilot.

## Credit and licence

Copied unchanged, apart from removing community contributions, from:

| Folder | Source | Licence |
| --- | --- | --- |
| [`agents/`](agents/) | [ed-donner/agents](https://github.com/ed-donner/agents) (selected folders) | MIT, © 2025 Ed Donner: [`agents/LICENSE`](agents/LICENSE) |
| [`alex/`](alex/) | [ed-donner/alex](https://github.com/ed-donner/alex) | MIT, © 2025 Ed Donner: [`alex/LICENSE`](alex/LICENSE) |

Check the upstream repos for newer versions. To run them, follow the setup in each upstream README (they use `uv` and need your own API keys in a local `.env`, which is git-ignored here).

## Which domain uses what

**Domain 1: Architecture & SDLC**

- [Week 2 · Lab 1: agent loop, tools and traces](agents/2_openai/1_lab1.ipynb)
- [Week 4 · Lab 5, Step 2: human-in-the-loop middleware](agents/4_langchain_langgraph/5_lab5.ipynb)
- [CrewAI reference projects: AGENTS.md](agents/3_crewai/reference/engineering_team/AGENTS.md)

**Domain 2: Tools & Environment**

- [Week 1 · Lab 3: tools from scratch](agents/1_foundations/3_lab3.ipynb)
- [Week 6 · Lab 1: using MCP servers](agents/6_mcp/1_lab1.ipynb)
- [Week 6 · Lab 2: write your own MCP server](agents/6_mcp/2_lab2.ipynb)

**Domain 3: Memory & State**

- [Week 2 · Lab 1, Part 3: adding memory](agents/2_openai/1_lab1.ipynb)
- [Week 4 · Lab 2: graph memory and persisting to SQLite](agents/4_langchain_langgraph/2_lab2.ipynb)
- [Week 6 · Lab 3: context engineering with MCP](agents/6_mcp/3_lab3.ipynb)

**Domain 4: Evaluation & Tuning**

- [Cyber-security agent (Semgrep MCP)](https://github.com/ed-donner/cyber)
- [Week 6 · Lab 5: observability, evaluation and feedback](agents/6_mcp/5_lab5.ipynb)
- [Week 4 · Lab 5, Step 3: the evaluator](agents/4_langchain_langgraph/5_lab5.ipynb)
- [Week 2 · Lab 3, Part 2: structured outputs](agents/2_openai/3_lab3.ipynb)

**Domain 5: Multi-Agent**

- [Alex: multi-agent SaaS capstone](alex)
- [Week 2 · Lab 2: orchestration by code vs. by LLM](agents/2_openai/2_lab2.ipynb)
- [Week 2 · Lab 4: deep research](agents/2_openai/4_lab4.ipynb)
- [Week 4 · Lab 4: deep agents and sub-agents](agents/4_langchain_langgraph/4_lab4.ipynb)
- [CrewAI: engineering team](agents/3_crewai/reference/engineering_team)
- [Week 5 · Day 5: the agent loop](agents/5_agent_frameworks/5_agent_loop/lab.md)

**Domain 6: Guardrails**

- [Week 2 · Lab 3, Part 3: guardrails](agents/2_openai/3_lab3.ipynb)
- [Week 4 · Lab 5, Step 2: approve before acting](agents/4_langchain_langgraph/5_lab5.ipynb)
- [Week 2 · Lab 3, optional: sandbox agents](agents/2_openai/3_lab3.ipynb)
