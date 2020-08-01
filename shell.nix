let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs-unstable {};
  bazel-deps = pkgs.callPackage ./nix/bazel-deps.nix {};

  bazel = pkgs.writeShellScriptBin "bazel" ''
    #! ${pkgs.runtimeShell}
    export CXX='${pkgs.gccStdenv.cc}/bin/g++'
    export LD='${pkgs.gccStdenv.cc}/bin/ld'
    export CC='${pkgs.gccStdenv.cc}/bin/gcc'

    # XXX: hack for macosX, this flags disable bazel usage of xcode
    # See: https://github.com/bazelbuild/bazel/issues/4231
    export BAZEL_USE_CPP_ONLY_TOOLCHAIN=1
    exec "${pkgs.bazel}/bin/bazel" "$@"
  '';
in pkgs.mkShell {
  buildInputs = [
    pkgs.gccStdenv.cc
    bazel
    bazel-deps
  ];
}
