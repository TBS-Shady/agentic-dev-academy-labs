# 0001: Lab pages are generated from the course source

**Status:** Accepted
**Date:** 2026-11-15

## Context

The labs here accompany the Agentic Dev Academy course. The course and its labs are written once, in the course source (kept privately with the paid course), and the labs must stay identical in both places.

## Options considered

1. **Hand-write the lab pages here:** easy to edit, but they drift from the course every time a lab changes.
2. **Generate them from the course source:** one source of truth. Pages here are output, not something to edit.

## Decision

Option 2. Lab 0, labs 1A–6D, the domain pages, the index and `labs/companion/README.md` are generated and arrive here through pull requests. `labs/companion/agents/` and `labs/companion/alex/` are third-party code (MIT, Ed Donner) copied as-is with their LICENSE files.

## Consequences

- Don't edit generated pages here; they would be overwritten. Report problems as issues.
- Changes to this repo's own files (README, CLAUDE.md, workflows, templates) are made here as normal.
