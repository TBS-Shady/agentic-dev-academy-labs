<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 2B: Give the coding agent an MCP server and a secret

**Domain 2: Implement tool use and environment interaction** · 40 min · 5 steps

**Goal:** Add MCP tools to the cloud agent with least privilege and verify they load.

**Exam skills you'll practise:** Add an MCP server · Configure a GitHub remote MCP server · Configure tool permissions

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Open the coding agent's MCP server settings

Settings → Code, planning, and automation → Copilot → **MCP servers**. Paste only the `microsoft-learn` block shown below (inside `mcpServers`) and save.

*From Example 2.2: Coding agent MCP configuration (repository settings)*

**Repository settings → Copilot → MCP servers**

```json
{
  "mcpServers": {
    "microsoft-learn": {
      "type": "http",
      "url": "https://learn.microsoft.com/api/mcp",
      "tools": ["microsoft_docs_search", "microsoft_docs_fetch"]
    },
    "github": {
      "type": "http",
      "url": "https://api.githubcopilot.com/mcp/readonly",
      "headers": {
        "Authorization": "Bearer $COPILOT_MCP_GITHUB_PERSONAL_ACCESS_TOKEN",
        "X-MCP-Toolsets": "repos,issues,pull_requests"
      },
      "tools": ["*"]
    },
    "sentry": {
      "type": "local",
      "command": "npx",
      "args": ["@sentry/mcp-server@1.2.3", "--host=$SENTRY_HOST"],
      "env": { "SENTRY_ACCESS_TOKEN": "$COPILOT_MCP_SENTRY_ACCESS_TOKEN" },
      "tools": ["get_issue_details"]
    }
  }
}
```

**What you should see:** After **Save MCP configuration**, GitHub validates the JSON. Paste only the `microsoft-learn` entry inside `mcpServers` for now.

### Step 2: Allow learn.microsoft.com through the agent's firewall

In the cloud agent's firewall settings (custom allowlist), add `learn.microsoft.com` if your setup blocks it.

**What you should see:** `learn.microsoft.com` is listed in the custom allowlist.

> **If something's off:** If you don't see firewall settings, your repo may use the default allowlist; continue and check the session log for blocked requests.

### Step 3: Create an issue

Create an issue: *"Add a docs/node-test.md page explaining node:test's beforeEach, citing Microsoft Learn or Node docs."* Assign to Copilot.

**What you should see:** 👀 and a draft PR adding `docs/node-test.md`.

### Step 4: Check that both Microsoft Learn tools started in the session

In **View session**, expand **Start MCP Servers** and confirm both Learn tools are listed. Find where the agent called `microsoft_docs_search`.

**What you should see:** In the session log, the **Start MCP Servers** step lists the server and its tools, for example:

**Session log · example**

```console
Start MCP Servers
  microsoft-learn (http)
    ✓ microsoft_docs_search
    ✓ microsoft_docs_fetch
```

### Step 5: Secret practice

Secret practice: create a fine-grained PAT with read-only **Contents** and **Issues** on agent-lab only. Add it as an **Agents** secret named `COPILOT_MCP_GITHUB_PERSONAL_ACCESS_TOKEN`, add the `github` block from the Step 1 example, and re-run a task. Confirm the token value is masked in logs.

**What you should see:** Settings → Secrets and variables → **Agents** shows `COPILOT_MCP_GITHUB_PERSONAL_ACCESS_TOKEN`. Logs show `***` where the token would appear.

> **If something's off:** Fine-grained PATs: Settings (your profile) → Developer settings → Personal access tokens → Fine-grained tokens. Limit to the agent-lab repo, read-only.

## Check your work

- [ ] Session log lists exactly the tools you allowed.
- [ ] The secret lives under Agents secrets, not Actions secrets, and starts with `COPILOT_MCP_`.

## Troubleshooting

- **Server fails to start:** Check the JSON is valid, `type` and `tools` are present, and the host is allowed by the firewall.
- **Tool listed but never used:** The task didn't need it, or the tool name is wrong. Tool names must match the server's exactly.

## Stretch goal

Remove the `github` override and confirm the default read-only GitHub MCP server still works.

## More practice

See [Domain 2: more practice](../README.md#more-practice).
