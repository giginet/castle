---
name: using-apple-container
description: Use Apple's container CLI instead of Docker for local image builds and container runs on supported Macs, especially when a project has a Dockerfile or Containerfile. Apply when a task requires container execution, inspection, or image management; editing a Dockerfile alone does not require starting a container.
---

# Use apple/container for local containers

When working on a Mac with a `Dockerfile` or `Containerfile`, use Apple's `container` CLI for the task's local build and run steps. Keep the existing Dockerfile: `container build` reads it directly and produces an OCI image. Do not invoke the `docker` executable, depend on a Docker daemon/socket, or install Docker as a workaround. Registry names such as `docker.io` and the filename `Dockerfile` are still valid.

## Before running commands

1. Check `command -v container`, `container --version`, `uname -m`, and `sw_vers -productVersion`. The official project supports Apple silicon with macOS 26 or later. If the CLI or required platform is unavailable, explain what prevents the requested local execution instead of silently switching tools.
2. Check `container system status`. If services are stopped and the task needs execution, use `container system start`. A permission error does not prove the service is stopped; resolve the access problem first. First startup may prompt to install a Linux kernel. Do not answer an interactive install or request elevated privileges without the user's authorization.
3. Use `container <subcommand> --help` to confirm options against the installed version. Some CLI subcommands are provided by plugins and may not show their help until the services start. The linked upstream reference documents the current branch and can differ from a local release.

## Work with a Dockerfile

- Build from the correct context directory, preserving the project's intended file and build arguments: `container build --tag my-app:dev --file Dockerfile .`. If `--file` is omitted, the CLI looks for `Dockerfile`, then `Containerfile`.
- Run the built image: `container run --rm my-app:dev`. For a web service: `container run --detach --rm --name my-app --publish 127.0.0.1:8080:8080 my-app:dev`.
- Use the `container` equivalents for logs, exec, inspection, image operations, and cleanup. Read [references/cli.md](references/cli.md) when you need flags or examples beyond a simple build and run.
- Follow the project's existing build context, port, environment, volume, and architecture requirements. Do not rewrite project scripts or deployment configuration solely to enforce this local tool preference.
- Check the installed CLI and upstream documentation before translating a workflow that depends on Docker Compose, Buildx-specific flags, the Docker socket, or other Docker-specific behavior. If `container` cannot perform the requested operation, state the unsupported part and the practical next step; do not silently fall back to Docker.

## Sources

- [apple/container README](https://github.com/apple/container) — supported host, service startup, and OCI images.
- [Official tutorial](https://github.com/apple/container/blob/main/docs/tutorials/start-here.md) — build, run, exec, and image publishing walkthrough.
- [Official command reference](https://github.com/apple/container/blob/main/docs/command-reference.md) — flags and subcommands; check local `--help` for version-specific behavior.
