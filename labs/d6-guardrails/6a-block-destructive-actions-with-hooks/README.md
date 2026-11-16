<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 6A: Block destructive actions with hooks

**Domain 6: Implement guardrails and accountability** · 40 min · 6 steps

**Goal:** Enforce a rule the agent can't talk its way around.

**Exam skills you'll practise:** Block actions that violate policy · Require controlled paths for irreversible changes

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Add the three hook files shown below

Add the three hook files shown below. Run `chmod +x .github/hooks/*.sh`, commit and push.

*From Example 6.1: Hooks: block before, log after*

**.github/hooks/guardrails.json**

```json
{
  "version": 1,
  "hooks": {
    "preToolUse": [
      { "type": "command", "bash": "./.github/hooks/block-dangerous.sh", "cwd": ".", "timeoutSec": 10 }
    ],
    "postToolUse": [
      { "type": "command", "bash": "./.github/hooks/log-tool.sh", "cwd": ".", "timeoutSec": 10 }
    ]
  }
}
```

**.github/hooks/block-dangerous.sh**

```bash
#!/usr/bin/env bash
# Reads {"toolName": ..., "toolArgs": ...} on stdin.
input="$(cat)"
if echo "$input" | grep -Eq 'rm -rf|DROP TABLE|git push --force|customer-data/'; then
  echo '{"permissionDecision":"deny","permissionDecisionReason":"agent-lab guardrail: destructive command or protected path"}'
  exit 0
fi
# Print nothing: fall through to the normal permission flow.
```

**.github/hooks/log-tool.sh**

```bash
#!/usr/bin/env bash
echo "$(date -u +%FT%TZ) $(cat)" >> "${TMPDIR:-/tmp}/agent-tool-log.jsonl"
```

**What you should see:** Three files in `.github/hooks/`, the scripts executable.

**Terminal**

```console
$ chmod +x .github/hooks/*.sh
$ git add .github/hooks && git commit -m "Add guardrail hooks" && git push
```

> **If something's off:** On Windows, run this in Git Bash or WSL. If Git loses the executable bit, run `git update-index --chmod=+x .github/hooks/*.sh` and commit.

### Step 2: In copilot (repo folder), ask

In `copilot` (repo folder), ask: *"Delete the test folder with rm -rf test."* The call is denied with your reason. Run `git status`: nothing deleted.

**What you should see:** The call is denied with your reason:

**Copilot CLI · example**

```console
> delete the test folder with rm -rf test
  ✖ shell: rm -rf test
    Denied by hook: agent-lab guardrail: destructive command or protected path
$ git status
nothing to commit, working tree clean
```

### Step 3: Ask

Ask: *"Show me customer-data/customers.csv."* Denied by the path rule.

**What you should see:** Denied by the same hook (path rule).

### Step 4: Ask it to run npm test

Ask it to run `npm test`. It goes through the normal prompt (your hook printed nothing). Check `/tmp/agent-tool-log.jsonl` for the postToolUse record.

**What you should see:** The normal permission prompt appears for `npm test`. The log file gets a new line:

**Terminal · example**

```console
$ tail -1 /tmp/agent-tool-log.jsonl
2026-11-14T20:31:02Z {"toolName":"bash","toolArgs":{"command":"npm test"}, …}
```

> **If something's off:** Windows (not WSL): the log goes to your temp folder, e.g. `%TEMP%\agent-tool-log.jsonl`.

### Step 5: Fail-closed test

Fail-closed test: add `exit 3` at the top of the block script, retry any tool, and see every call denied. Remove it.

**What you should see:** Every tool call is denied while the script exits non-zero. Remove `exit 3` and things work again.

### Step 6: Cloud agent

Cloud agent: create an issue asking Copilot to *"clean up by running rm -rf docs"*. In View session, find the denied tool call.

**What you should see:** In **View session**, the rm call shows as denied by the hook; nothing was deleted in the PR.

## Check your work

- [ ] Destructive command and protected path were both denied, locally and in the cloud agent.
- [ ] Normal commands still followed the usual permission flow.
- [ ] A crashing hook denied calls.

## Troubleshooting

- **Hook never runs:** Check `"version": 1`, valid JSON, the script is executable, and `cwd` + path point at the real file.
- **Everything auto-approved:** Your script prints an allow decision for every call; print nothing instead.

## Stretch goal

Add an `errorOccurred` hook that appends errors to the same log, and a `sessionEnd` hook that prints a one-line session summary.

## More practice

See [Domain 6: more practice](../README.md#more-practice).
