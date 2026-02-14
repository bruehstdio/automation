# Agent Instructions

Guidelines for AI agents working in this repository.

## General Rules

1. **Keep the README up to date.** Whenever you add, remove, or modify a script, workflow, or any other notable content, update `README.md` to reflect the change. Every new item should have a brief description and usage example.

2. **Follow existing conventions.** Match the style, structure, and naming patterns already present in the repository. Scripts go in `scripts/`, workflows go in `.github/workflows/`.

3. **Keep scripts portable.** Use `#!/usr/bin/env bash` with `set -euo pipefail`. Validate required tools and arguments at the top of each script. Provide a usage message when invoked without arguments.

4. **Workflow inputs should have sensible defaults.** Use `workflow_dispatch` with typed inputs. Document required secrets in the README.

5. **Don't over-engineer.** This is a utility repo. Keep things simple, self-contained, and well-documented.

6. **Test before committing.** Run `shellcheck` on shell scripts when available. Validate workflow YAML syntax.
