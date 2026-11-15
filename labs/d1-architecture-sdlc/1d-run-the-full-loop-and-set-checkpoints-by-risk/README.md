<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 1D: Run the full loop and set checkpoints by risk

**Domain 1: Prepare agent architecture and SDLC processes** · 45 min · 5 steps

**Goal:** Make agent work visible as reviewable artifacts and add human checkpoints only where they matter.

**Exam skills you'll practise:** Degree of autonomy · Inspectable artifacts · Human intervention without slowing delivery

> **Before you start:** Set up the practice repo in [Lab 0: Set up your lab](../../00-setup) if you haven't yet. Open a terminal in your `agent-lab` folder and make sure you're on `main` with no uncommitted changes (`git status`).

## Steps

### Step 1: Open an Agent task issue

Open an Agent task issue: *"Add a DELETE /tasks/:id route that uses canDeleteTask from src/auth/session.js."* Assign it to Copilot.

**What you should see:** 👀 on the issue, then a draft PR linked in the timeline.

### Step 2: Track it

Track it: 👀 reaction (acknowledged) → "Copilot started work" in the timeline → **View session** for live logs. From a terminal: `gh agent-task list` and `gh agent-task view <id> --log --follow`.

**What you should see:** From the terminal you can list and follow the task:

**Terminal · example output**

```console
$ gh agent-task list
#14  Add DELETE /tasks/:id route   in progress   copilot/add-delete-route
$ gh agent-task view 14 --log --follow
… streams the session log: reading files, running npm test, committing …
```

### Step 3: When the draft PR appears, approve workflows, then request a …

When the draft PR appears, approve workflows, then request a review from **Copilot** (Reviewers → Copilot) and read its comments.

**What you should see:** Copilot's review appears as review comments on specific lines, like a teammate's.

### Step 4: Leave a review comment starting with @copilot asking for one …

Leave a review comment starting with `@copilot` asking for one change (e.g. "return 403 instead of 404 when not allowed"). Confirm it pushes to the same branch.

**What you should see:** Copilot reacts 👀 to your comment, starts a new session, and pushes a new commit to the same branch.

> **If something's off:** Only users with write access can trigger it, and only on open PRs.

### Step 5: Fill in this autonomy table for agent-lab and save it as docs…

Fill in this autonomy table for agent-lab and save it as `docs/agent-autonomy.md`:

**docs/agent-autonomy.md**

```markdown
| Change                              | Risk        | Autonomy                         |
|-------------------------------------|-------------|----------------------------------|
| Typos, formatting, comments         | Low         | Agent runs; normal PR review     |
| New tests                           | Low         | Agent runs; normal PR review     |
| src/tasks.js, src/server.js         | Medium      | Agent runs; PR review + CI       |
| src/billing/**                      | Medium/High | Plan approval, then PR review    |
| src/auth/**                         | High (sec)  | Plan approval + security review  |
| customer-data/**                    | Compliance  | Agent may not read (exclusion)   |
| Release, deploy, delete data        | High (ops)  | Human approval before it happens |
```

**What you should see:** Your table matches each kind of change to an autonomy level. Approval sits only on billing, auth, customer data and deploys.

**Terminal · commit and push**

```console
$ git add .
$ git commit -m "Add <what you added>"
$ git push
```

## Check your work

- [ ] You can point to the issue, session log, PR timeline, Copilot review and your @copilot iteration for one task.
- [ ] Your table puts approval only on billing, auth, data and deploy.

## Troubleshooting

- **@copilot comment ignored:** Copilot only responds on open PRs, to users with write access.

## Stretch goal

Make the table real: Domain 6 lab 6c turns the auth row into CODEOWNERS + a ruleset.

## More practice

See [Domain 1: more practice](../README.md#more-practice).
