# How to

## Generate 3rd party deps

```bash
$ nix-shell --pure
$ gen_maven_deps.sh generate --repo-root $(pwd) --deps ./dependencies.yaml --sha-file ./3rdparty/workspace.bzl
```

## Build and run example

```bash
$ nix-shell --pure
$ bazel build //example-cats
$ bazel-bin/example-cats/example-cats Guest!
```
