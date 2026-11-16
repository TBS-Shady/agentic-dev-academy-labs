<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 6D: Production approvals, exclusions and the audit trail

**Domain 6: Implement guardrails and accountability** · 40 min · 5 steps · Org admin

**Goal:** Hold irreversible actions for a person and prove afterwards who did what.

**Exam skills you'll practise:** Classify actions by risk · Require explicit authorization for irreversible changes · Traceability

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Settings → Environments → production

Settings → Environments → **production**: add yourself as required reviewer and enable **Prevent self-review** (self-review prevention needs a second person to test fully).

**What you should see:** Settings → Environments → production shows you as a required reviewer.

### Step 2: Add deploy.yml shown below with on

Add `deploy.yml` shown below with `on: workflow_dispatch`. Run it: the job waits for approval, and its secrets aren't available until approved.

*From Example 6.3: Who must approve what: CODEOWNERS + ruleset + environment*

**.github/CODEOWNERS**

```text
# Security reviews anything touching auth or workflows
/src/auth/            @your-username
/.github/workflows/   @your-username
/.github/hooks/       @your-username
```

**Ruleset on main (Settings → Rules → Rulesets)**

```text
Target: default branch          Enforcement: Active
☑ Restrict deletions            ☑ Block force pushes
☑ Require a pull request        Required approvals: 1
   ☑ Require review from Code Owners
☑ Require status checks: test, scope, CodeQL
   ☑ Require branches to be up to date
Bypass list: (empty — add a single trusted bot only if a real exception exists)
```

**.github/workflows/deploy.yml (excerpt)**

```yaml
jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: production   # required reviewer + "Prevent self-review"
    steps:
      - run: echo "deploying ${{ github.sha }}"
```

**What you should see:** The run pauses with *Waiting for review: production needs approval*. Approve to continue.

### Step 3: Settings → Copilot → Content exclusion

Settings → Copilot → **Content exclusion**: add `/customer-data/**`. Reload VS Code and ask Copilot about the CSV; it can't use it.

*From Example 6.4: Content exclusion*

**Repository content exclusion**

```yaml
- "/customer-data/**"
- "**/.env"
```

**Organization content exclusion**

```yaml
"*":
  - "**/.env"
agent-lab:
  - "/customer-data/**"
```

**What you should see:** Copilot can't use the CSV in IDE chat; it says the file is excluded or ignores it.

> **If something's off:** Changes can take up to 30 minutes to reach the IDE. Run **Developer: Reload Window** to apply sooner.

### Step 4: Org admin In your org

**Org admin** In your org: Settings → Audit log. Find `pull_request.create` events from Copilot and inspect the `actor_is_agent` and `agent_session_id` fields. Note how long the log is retained and where you'd stream it (SIEM, Event Hubs, S3) to keep it longer.

**What you should see:** Audit log entries for Copilot's PR events with `actor_is_agent` and an `agent_session_id`.

### Step 5: Org admin Review the org's Copilot policies

**Org admin** Review the org's Copilot policies: cloud agent, MCP servers, Memory, CLI, allowed models. Write one sentence on why each is set the way it is.

**What you should see:** One sentence per policy explaining its setting.

## Check your work

- [ ] The deploy job waited for an approval you gave.
- [ ] Copilot can't read the excluded folder in the IDE.
- [ ] You found an agent event and its session id in the audit log.

## Troubleshooting

- **No agent fields in the audit log:** Agent fields appear on events created by agents; trigger a Copilot PR in an org repo first. Some audit features need GitHub Enterprise Cloud.

## Stretch goal

Search the audit log for `action:artifact.destroy` after deleting an artifact, and confirm who did it.

## More practice

See [Domain 6: more practice](../README.md#more-practice).
