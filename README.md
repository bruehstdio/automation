# automation

A collection of automation scripts and GitHub Actions workflows for common repository management tasks.

## Contents

### Scripts

- **[`scripts/clone-all-repos.sh`](scripts/clone-all-repos.sh)** — Clone (or update) all repositories for a given GitHub owner or organization using the `gh` CLI.

  ```bash
  ./scripts/clone-all-repos.sh <owner/org> [destination_dir]
  ```

### Workflows

- **[`.github/workflows/sync-repo.yml`](.github/workflows/sync-repo.yml)** — Reusable workflow that syncs a repository/branch from one git platform to another. Can be triggered manually or called from other workflows. Supports cross-platform syncing (GitHub, GitLab, Bitbucket, etc.).

  **Inputs:**

  | Input | Description | Default |
  |---|---|---|
  | `source_host` | Source git host (e.g., `github.com`) | `github.com` |
  | `source_repo` | Source repository (`owner/repo`) | *required* |
  | `source_branch` | Branch to sync from | `main` |
  | `target_host` | Target git host (e.g., `gitlab.com`) | *required* |
  | `target_repo` | Target repository (`owner/repo`) | *required* |
  | `target_branch` | Branch to push to | same as source |
  | `force_push` | Force push to target | `true` |

  **Secrets:**

  | Secret | Description |
  |---|---|
  | `SOURCE_TOKEN` | Access token for source repository |
  | `TARGET_TOKEN` | Access token for target repository (basic auth format) |

  > **Note:** When triggering manually, ensure `SOURCE_TOKEN` and `TARGET_TOKEN` are configured as repository secrets.

  **Usage from another workflow:**

  ```yaml
  jobs:
    sync:
      uses: danielfbm/automation/.github/workflows/sync-repo.yml@main
      with:
        source_repo: "myorg/myrepo"
        target_host: "gitlab.com"
        target_repo: "myorg/myrepo"
      secrets:
        SOURCE_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        TARGET_TOKEN: ${{ secrets.GITLAB_TOKEN }}
  ```
