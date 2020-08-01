# See. https://tpolecat.github.io/2017/04/25/scalac-flags.html
SCALAC_OPTS = [
    "-encoding", "UTF-8",
    "-deprecation",
    "-explaintypes",           # Explain type errors in more detail.
    "-Yrangepos",              # Better squiggles in VSCode, see https://developer.lightbend.com/blog/2018-09-14-sbt-1-2-3/index.html
    "-unchecked",
    "-feature",                # Emit warning and location for usages of features that should be imported explicitly.
    "-language:higherKinds",
    "-language:existentials",
    "-language:implicitConversions",
    "-Xlint:stars-align",      # Pattern sequence wildcard must align with sequence component.
    "-Xsource:2.13",
    "-Ywarn-dead-code",
    "-Ywarn-unused:imports",
    "-Ypartial-unification",
    "-Ypatmat-exhaust-depth", "40",
    "-Xfatal-warnings",
]

scala_binary(
    name = "example-cats",
    srcs = glob(["*.scala"]),
    scalacopts = SCALAC_OPTS,
    deps = [
        "//3rdparty/jvm/org/typelevel:cats_effect",
        "//3rdparty/jvm/org/typelevel:cats_core",
        "//example-proto:common_proto_scala",
    ],
    visibility = ["//visibility:public"],
    main_class = "App",
    unused_dependency_checker_mode = "error",
)

scala_test(
    name = "test",
    srcs = glob(["test/*.scala"]),
    deps = [
        "example-cats",
        "//3rdparty/jvm/org/typelevel:cats_effect",
        "//3rdparty/jvm/org/typelevel:cats_core",
    ]
)
