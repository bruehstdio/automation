# automation

A collection of automation scripts and GitHub Actions workflows for common repository management tasks.

## Contents

### Scripts

- **[`scripts/clone-all-repos.sh`](scripts/clone-all-repos.sh)** — Clone (or update) all repositories for a given GitHub owner or organization using the `gh` CLI.

  ```bash
  ./scripts/clone-all-repos.sh <owner/org> [destination_dir]
  ```

### Workflows

- **[`.github/workflows/sync-repo.yml`](.github/workflows/sync-repo.yml)** — Manually triggered workflow that syncs a source repository/branch to a target repository/branch. Supports force-push and configurable branch names. Requires a `SYNC_TOKEN` secret with access to both repositories.

  | Input | Description | Default |
  |---|---|---|
  | `source_repo` | Source repository (`owner/repo`) | *required* |
  | `source_branch` | Branch to sync from | `main` |
  | `target_repo` | Target repository (`owner/repo`) | *required* |
  | `target_branch` | Branch to push to | same as source |
  | `force_push` | Force push to target | `true` |
