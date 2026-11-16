<!-- Generated from the Agentic Dev Academy course source. Don't edit this file; report problems as an issue. -->

# Lab 0: Set up your lab

Every lab in this course runs against the same small repository, **agent-lab**: a zero-dependency Node.js task tracker with tests. It has an `auth/` folder (high-risk code), a `billing/` folder (an area agents must stay out of in some labs), a `customer-data/` folder (for content exclusion) and a long runbook (for skills and progressive disclosure). It also has a real boundary bug in `dueSoon()` that several labs use.

## What you need

- **GitHub account with a paid Copilot plan:** Copilot Pro, Pro+, Business or Enterprise. The coding agent (cloud agent) isn't available on Copilot Free. On Business/Enterprise an admin must enable the cloud agent policy.
- **VS Code with GitHub Copilot Chat:** Signed in to the same GitHub account. Used for agent mode, custom agents, handoffs and mcp.json.
- **Copilot CLI:** `npm install -g @github/copilot`, then run `copilot` and sign in.
- **GitHub CLI 2.80+:** `gh auth login`. Needed for `gh repo create` and `gh agent-task`.
- **Node.js 20+ and Git:** The sample app uses only Node's built-in modules.
- **Optional: an organization you administer:** A free test org lets you try policies, content exclusion, rulesets at org level and the audit log. Labs that need it are tagged **Org admin**.

## Steps

### Step 1: Check your tools

Open a terminal. On Windows use **Git Bash** (installed with Git for Windows) so the lab commands work as written. Check each tool:

**Terminal · example output**

```console
$ git --version
git version 2.47.0
$ node --version
v22.23.4
$ gh --version
gh version 2.80.0
```

**What you should see:** A version number for each. Node must be 20 or newer.

> **If something's off:** Missing a tool? Install Git from git-scm.com, Node.js LTS from nodejs.org, and the GitHub CLI from cli.github.com, then open a new terminal.

### Step 2: Sign in to GitHub from the terminal

**Terminal**

```console
$ gh auth login
? Where do you use GitHub?  GitHub.com
? What is your preferred protocol for Git operations?  HTTPS
? How would you like to authenticate GitHub CLI?  Login with a web browser
! First copy your one-time code: ABCD-1234
✓ Logged in as your-username
```

**What you should see:** `✓ Logged in as your-username`. Check any time with `gh auth status`.

### Step 3: Install Copilot CLI

**Terminal**

```console
$ npm install -g @github/copilot
$ copilot
```

The first run asks you to sign in (it opens your browser) and whether to trust the current folder.

**What you should see:** The Copilot CLI prompt. Type `/exit` (or press <kbd>Ctrl</kbd>+<kbd>C</kbd> twice) to leave.

> **If something's off:** If your organization provides Copilot, the Copilot CLI policy must be enabled by an admin.

### Step 4: Create the agent-lab repo

Go to the folder where you keep projects, download the setup script from the labs repo, then run it. (You can also copy it from the next page.)

**Terminal · Git Bash example**

```console
$ cd ~
$ curl -fsSLO https://raw.githubusercontent.com/TBS-Shady/agentic-dev-academy-labs/main/labs/00-setup/create-agent-lab.sh
$ bash create-agent-lab.sh
```

**What you should see:** The script creates the files, runs the tests and pushes a private repo:

**Terminal · real output from agent-lab**

```console
$ npm test
✔ invoiceTotal adds tax (1.0ms)
✔ addTask requires a title (1.1ms)
✔ completeTask marks a task done (0.2ms)
✔ dueSoon finds a task due tomorrow (0.2ms)
ℹ tests 4
ℹ pass 4
ℹ fail 0
```

**Terminal · end of the script (example)**

```console
[main (root-commit) e86c893] Initial agent-lab
 11 files changed, 122 insertions(+)
✓ Created repository your-username/agent-lab on GitHub
✓ Added remote https://github.com/your-username/agent-lab.git
✓ Pushed commits to https://github.com/your-username/agent-lab.git
```

> **If something's off:** "agent-lab already exists": delete or rename the old folder, or the old repo on GitHub, and run again.

### Step 5: The full setup script

Run [`create-agent-lab.sh`](create-agent-lab.sh) from the folder where you keep your repos:

**create-agent-lab.sh**

```bash
mkdir agent-lab && cd agent-lab && git init -b main
mkdir -p src/auth src/billing customer-data docs test

cat > package.json <<'EOF'
{
  "name": "agent-lab",
  "version": "1.0.0",
  "private": true,
  "scripts": {
    "start": "node src/server.js",
    "test": "node --test"
  }
}
EOF

cat > src/tasks.js <<'EOF'
const tasks = [];
let nextId = 1;

function addTask(title, dueDate, priority = "normal") {
  if (!title) throw new Error("title is required");
  const task = { id: nextId++, title, dueDate: dueDate ? new Date(dueDate) : null, priority, done: false };
  tasks.push(task);
  return task;
}

function completeTask(id) {
  const task = tasks.find(t => t.id === id);
  if (!task) throw new Error("task not found");
  task.done = true;
  return task;
}

function listTasks({ done } = {}) {
  return done === undefined ? [...tasks] : tasks.filter(t => t.done === done);
}

// Returns open tasks due within `days` days of `now`.
function dueSoon(days, now = new Date()) {
  const limit = new Date(now.getTime() + days * 86400000);
  return tasks.filter(t => !t.done && t.dueDate && t.dueDate < limit);
}

function reset() { tasks.length = 0; nextId = 1; }

module.exports = { addTask, completeTask, listTasks, dueSoon, reset };
EOF

cat > src/server.js <<'EOF'
const http = require("node:http");
const { addTask, listTasks } = require("./tasks");

const server = http.createServer((req, res) => {
  if (req.method === "GET" && req.url === "/tasks") {
    res.writeHead(200, { "content-type": "application/json" });
    return res.end(JSON.stringify(listTasks()));
  }
  if (req.method === "POST" && req.url === "/tasks") {
    let body = "";
    req.on("data", c => (body += c));
    return req.on("end", () => {
      const { title, dueDate, priority } = JSON.parse(body || "{}");
      res.writeHead(201, { "content-type": "application/json" });
      res.end(JSON.stringify(addTask(title, dueDate, priority)));
    });
  }
  res.writeHead(404).end();
});

if (require.main === module) server.listen(3000, () => console.log("http://localhost:3000"));
module.exports = server;
EOF

cat > src/auth/session.js <<'EOF'
// HIGH RISK: authorization logic. Changes need security review.
function canDeleteTask(user, task) {
  return Boolean(user) && (user.role === "admin" || user.id === task.ownerId);
}
module.exports = { canDeleteTask };
EOF

cat > src/billing/invoice.js <<'EOF'
// Amounts are integer cents.
function invoiceTotal(lineItems, taxRate) {
  const subtotal = lineItems.reduce((sum, i) => sum + i.unitCents * i.qty, 0);
  return Math.round(subtotal * (1 + taxRate));
}
module.exports = { invoiceTotal };
EOF

cat > customer-data/customers.csv <<'EOF'
id,name,email
1,Test Customer,test.customer@example.com
2,Sample Buyer,sample.buyer@example.com
EOF

cat > docs/release-runbook.md <<'EOF'
# Release runbook
1. Confirm main is green and all required checks pass.
2. Bump the version in package.json (semver).
3. Update CHANGELOG.md with every merged PR since the last tag.
4. Tag the release: git tag vX.Y.Z && git push --tags.
5. Create a GitHub release from the tag with the changelog section.
6. Watch error rates for 30 minutes; roll back by reverting the release PR if they rise.
EOF

cat > test/tasks.test.js <<'EOF'
const test = require("node:test");
const assert = require("node:assert");
const t = require("../src/tasks");

test.beforeEach(() => t.reset());

test("addTask requires a title", () => {
  assert.throws(() => t.addTask(""), /title is required/);
});

test("completeTask marks a task done", () => {
  const task = t.addTask("write docs");
  assert.equal(t.completeTask(task.id).done, true);
});

test("dueSoon finds a task due tomorrow", () => {
  const now = new Date("2026-01-01T00:00:00Z");
  t.addTask("pay invoice", "2026-01-01T12:00:00Z");
  assert.equal(t.dueSoon(1, now).length, 1);
});
EOF

cat > test/billing.test.js <<'EOF'
const test = require("node:test");
const assert = require("node:assert");
const { invoiceTotal } = require("../src/billing/invoice");

test("invoiceTotal adds tax", () => {
  assert.equal(invoiceTotal([{ unitCents: 1000, qty: 2 }], 0.1), 2200);
});
EOF

printf "node_modules/\n" > .gitignore
npm install          # creates package-lock.json (no dependencies)
npm test             # 4 tests should pass
git add . && git commit -m "Initial agent-lab"
gh repo create agent-lab --private --source . --push
```

**What you should see:** This is what the script does, in case you'd rather run it piece by piece.

### Step 6: Confirm on GitHub

**Terminal**

```console
$ gh repo view --web
```

**What you should see:** The repo page opens with folders `src`, `test`, `docs`, `customer-data`. Click the **Copilot** icon or open **Issues → New issue** and check that **Copilot** appears under Assignees.

> **If something's off:** No Copilot under Assignees: the cloud agent isn't enabled for your plan, org or this repo yet. You can still do the CLI and VS Code labs.

### Step 7: Meet the planted bug

`dueSoon(days)` should include tasks due exactly *days* from now, but it uses `<` instead of `<=`. Prove it:

**Terminal · real output**

```console
$ node -e "const t=require('./src/tasks');t.addTask('x','2026-01-02T00:00:00Z');console.log(t.dueSoon(1,new Date('2026-01-01T00:00:00Z')).length)"
0
```

**What you should see:** `0`, when the answer should be `1`. Leave it broken: Labs 1A and 4B use it.

## Check your setup

- [ ] `npm test` reports 4 passing tests.
- [ ] The repository exists on GitHub and its default branch is `main`.
- [ ] On the repo page, the Copilot icon lets you start an agent task (or you can assign an issue to Copilot).
- [ ] `copilot` starts in the repo folder and shows your account.

**The planted bug.** `dueSoon(1)` leaves out a task due *exactly* one day from now because it uses `<` instead of `<=`. The existing test doesn't cover the boundary, so CI stays green. Don't fix it yourself: Domains 1 and 4 use it to compare a vague issue with an agent-ready one.
