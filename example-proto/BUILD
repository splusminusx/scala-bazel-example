load('@io_bazel_rules_scala//scala_proto:scala_proto.bzl', 'scalapb_proto_library')

proto_library(
  name = 'common_proto',
  srcs = glob(['*.proto']),
)

scalapb_proto_library(
  name = 'common_proto_scala',
  deps = [':common_proto'],
  visibility = ["//visibility:public"],
)
