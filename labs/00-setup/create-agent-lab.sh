#!/usr/bin/env bash
# Creates the agent-lab practice repo used by every lab in the GH-600 Study Course.
# Run in Git Bash, WSL, macOS or Linux. Generated from the Agentic Dev Academy course source.
set -e
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
