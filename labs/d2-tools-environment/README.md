<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Domain 2: Implement tool use and environment interaction

Exam weight: 20–25%. Do the labs in order; later labs reuse earlier files.

| Lab | Time | Level |
| --- | --- | --- |
| [2A: Prepare the agent's environment](2a-prepare-the-agents-environment/) | 25 min | Core |
| [2B: Give the coding agent an MCP server and a secret](2b-give-the-coding-agent-an-mcp-server-and-a-secret/) | 40 min | Core |
| [2C: Workspace MCP and tool-scoped custom agents in VS Code](2c-workspace-mcp-and-tool-scoped-custom-agents-in/) | 35 min | Core |
| [2D: Permissions, branch scope and CI invocation](2d-permissions-branch-scope-and-ci-invocation/) | 45 min | Core |

## More practice

### Alternative lab on Azure

[Exercise 2: Tool use and environment](https://github.com/sameeraman/gh-600-lab-instructions/blob/main/exercise-02-tool-use-and-environment.md) (~55 min). Four custom agents with graded tool permissions, MCP servers, and copilot-setup-steps.yml. Part of the community GH-600 lab guides by GitHub user sameeraman.

> **Note:** Fix before you run Step 5: the npm packages `@github/mcp-server` and `@playwright/mcp-server` don't exist (npm returns 404). Use GitHub's remote server (`"type": "http", "url": "https://api.githubcopilot.com/mcp/"`) and the `@playwright/mcp` package with a pinned version. A root `.mcp.json` is read by local tools; the cloud agent uses the repository's MCP settings (see Example 2.2).

### Build it from scratch

Python labs from Ed Donner's open-source agent-engineering course (MIT licence), copied into [`labs/companion`](../companion) with credit. Background only: they use paid model APIs and don't cover Copilot.

- [Week 1 · Lab 3: tools from scratch](../companion/agents/1_foundations/3_lab3.ipynb): Write a tool definition as JSON and handle the tool call yourself. Shows why clear tool names and descriptions decide which tool the model picks.
- [Week 6 · Lab 1: using MCP servers](../companion/agents/6_mcp/1_lab1.ipynb): Connect an agent to existing MCP servers (Python and Node-based).
- [Week 6 · Lab 2: write your own MCP server](../companion/agents/6_mcp/2_lab2.ipynb): Build an MCP server and expose your own tools: what's behind an mcpServers entry.
