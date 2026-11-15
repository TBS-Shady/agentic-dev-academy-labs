# CLAUDE.md

Context for Claude Code sessions in this repo. Keep it short and current.

## What this repo is

The free, public lab repo for Agentic Dev Academy, a paid GH-600 study course. The course website and its content live in the private `agentic-dev-academy-app` repo; this repo only holds the hands-on labs that the course points users to.

**This repo is public.** Everything committed here, including this file and every commit message, can be read by anyone. Keep out:

- paid course content: lessons, practice questions, flashcards, the mock exam
- secrets, API keys, tokens, connection strings, account or subscription IDs
- employer, client or customer details, internal URLs and local file paths
- real exam questions or answers, or anything covered by the exam's confidentiality agreement

## Layout

- `labs/00-setup/`, `labs/d<N>-<domain>/<id>-<title>/` - **generated** lab pages, published from the course source in `agentic-dev-academy-app`. Don't edit them here; change the source there and republish
- `labs/companion/` - third-party code (MIT, Ed Donner) copied as-is. Keep the LICENSE files and don't reformat it
- `docs/decisions/` - decision records (copy `0000-template.md`)

## Rules

- Don't commit to `main` directly. Branch, then merge through a pull request.
- Keys and endpoints go in environment variables or a git-ignored `.env`. Commit a `.env.example` with placeholder values.
- Pin dependency, action and image versions.
- Keep `.github/workflows/checks.yml` and `.pre-commit-config.yaml` passing.

## Tracking work

- Tasks: GitHub Issues in this repo (templates: Lab, Task). Reference them in commits and PRs (`Closes #12`).
- Changes: add a line to `CHANGELOG.md` under **Unreleased**.
- Decisions: `docs/decisions/` when choosing between real alternatives.
