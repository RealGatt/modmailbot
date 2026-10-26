Dokploy deploys this repository using `.dokploy/compose.yaml` and the official
`oven/bun:1.4.4` image. No application image build or PM2 is required.

Configuration and mutable data are host mounts under
`/var/lib/dokploy-discord-bots/persistent/modmail`.
`runtime.env` supplies deployment environment values; keep it and all credentials
outside Git. The code checkout is read-only. Each deployment recreates the
container, copies the Git code into its fresh working directory, installs locked
dependencies, and starts Bun directly. The dependency volume is refreshed by
`bun install --frozen-lockfile`; state mounts are preserved across deployments.

Set the Dokploy custom Compose command to `compose -p <app-name> -f
.dokploy/compose.yaml up -d --force-recreate --remove-orphans` so unchanged Compose
configuration still deploys updated Git code.
