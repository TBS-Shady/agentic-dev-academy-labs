<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 2C: Workspace MCP and tool-scoped custom agents in VS Code

**Domain 2: Implement tool use and environment interaction** · 35 min · 4 steps

**Goal:** Share MCP servers with every developer and control which agent can use which tool.

**Exam skills you'll practise:** Identify and configure tools · Configure tool permissions · Add an MCP server as a tool to an agent

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Commit .vscode/mcp.json with the github and microsoft-learn s…

Commit `.vscode/mcp.json` with the `github` and `microsoft-learn` servers shown below. Open the Command Palette → **MCP: List Servers** and start both.

*From Example 2.3: VS Code workspace MCP: .vscode/mcp.json*

**.vscode/mcp.json**

```json
{
  "inputs": [
    { "type": "promptString", "id": "sentry-token", "description": "Sentry token", "password": true }
  ],
  "servers": {
    "github": { "type": "http", "url": "https://api.githubcopilot.com/mcp/" },
    "microsoft-learn": { "type": "http", "url": "https://learn.microsoft.com/api/mcp" },
    "sentry": {
      "type": "stdio",
      "command": "npx",
      "args": ["-y", "@sentry/mcp-server@1.2.3"],
      "env": { "SENTRY_ACCESS_TOKEN": "${input:sentry-token}" }
    }
  }
}
```

**What you should see:** **MCP: List Servers** shows `github` and `microsoft-learn` as Running.

**Terminal · commit and push**

```console
$ git add .
$ git commit -m "Add <what you added>"
$ git push
```

> **If something's off:** Open the Command Palette with <kbd>Ctrl</kbd>+<kbd>Shift</kbd>+<kbd>P</kbd>. The GitHub server may ask you to sign in the first time.

### Step 2: Create .github/agents/docs-researcher.agent.md shown below

Create `.github/agents/docs-researcher.agent.md` shown below. Select it in the agents dropdown and ask a Node.js question. Confirm it calls Learn tools and refuses to edit.

*From Example 2.4: Custom agent with an explicit tool allow list*

**.github/agents/docs-researcher.agent.md**

```markdown
---
name: docs-researcher
description: Answers questions about Node.js and GitHub APIs using official docs. Read-only.
tools: ["read", "search", "microsoft-learn/*"]
---
Look up answers in the repository and Microsoft Learn docs.
Cite the doc URL for every claim. Never edit files.
```

**What you should see:** With docs-researcher selected, the answer cites Microsoft Learn URLs. Asking it to edit a file gets a refusal or a note that it can't edit.

### Step 3: Change its tools to ["read", "search"]

Change its tools to `["read", "search"]`. Ask the same question. It can no longer reach Learn — the profile's allow list wins over what the workspace has configured.

**What you should see:** Same question, but no Learn citations this time: the tool isn't on the agent's list, even though the workspace has the server.

### Step 4: Create reviewer.agent.md with tools

Create `reviewer.agent.md` with `tools: []` and confirm it can only answer from what you paste in.

**What you should see:** The reviewer can discuss pasted code but can't search, read or run anything.

## Check your work

- [ ] Other developers who clone the repo get the same MCP servers.
- [ ] You can explain why the agent lost Learn access in step 3.

## Troubleshooting

- **Agent not in dropdown:** Profiles load from `.github/agents/` on the branch you have checked out, and agents with `user-invocable: false` are hidden.

## Stretch goal

Add a local stdio server with a pinned version (`@1.2.3`) and explain why pinning matters for reproducible agent tools.

## More practice

See [Domain 2: more practice](../README.md#more-practice).
