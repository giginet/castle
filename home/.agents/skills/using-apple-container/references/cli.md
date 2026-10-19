# apple/container CLI recipes

Use these commands after confirming the installed CLI version and starting the container service. Replace names, paths, ports, and image references with the project's values.

## Service and build

```sh
container system status
container system start                   # Only when execution needs a stopped service
container build -t my-app:dev -f Dockerfile .
container image list
```

The final `.` is the build context. `-f` selects a Dockerfile outside the default location. The builder accepts common BuildKit options, including `--build-arg KEY=value`, `--target stage`, `--no-cache`, `--secret id=name,src=path`, `--ssh default`, and repeatable `--tag`. Consult `container build --help` for the installed release before using less common flags. The default builder runs with 2 CPUs and 2048 MB of memory; use `--cpus` and `--memory` if a build needs different limits.

## Run and inspect

```sh
container run --rm my-app:dev
container run -d --rm --name my-app -p 127.0.0.1:8080:8080 my-app:dev
container list --all
container logs my-app
container exec -it my-app sh
container inspect my-app
container stop my-app
```

The image's default command runs unless a command follows its image name. `--rm` removes the container after it exits; `-d` runs it in the background. Use `-e KEY=value` or `--env-file path` for environment values. `-p [host-ip:]host-port:container-port[/protocol]` forwards a port; specify `127.0.0.1` when only local access is needed. A service inside the container generally must listen on `0.0.0.0` for forwarding to reach it. `container exec` requires a running container.

## Files, images, and architecture

```sh
container run --rm --volume "$(pwd)":/workspace:ro --workdir /workspace my-app:dev
container image pull alpine:latest
container image tag my-app:dev registry.example.com/team/my-app:dev
container image push registry.example.com/team/my-app:dev
```

For host folders, `--volume host-path:container-path[:ro]` or `--mount source=host-path,target=container-path` creates a bind mount. Named volumes use `container volume create NAME` followed by `--volume NAME:/path`. `container image push` publishes externally, so run it only when publishing is within the task's authorization.

The CLI defaults to an arm64 image variant on Apple silicon. Use `container build --platform linux/amd64 ...` or `container run --platform linux/amd64 ...` when the target architecture requires it. The official multiplatform guide also shows repeated `--arch arm64 --arch amd64` when building a single image with both variants. Verify the installed version's flags before relying on cross-architecture behavior.

## Documentation

- [Command reference](https://github.com/apple/container/blob/main/docs/command-reference.md)
- [Mounts and volumes](https://github.com/apple/container/blob/main/docs/volumes.md)
- [Networking and port forwarding](https://github.com/apple/container/blob/main/docs/networking.md)
- [Multiplatform images](https://github.com/apple/container/blob/main/docs/multiplatform-images.md)
