# Do not edit. bazel-deps autogenerates this file from ./dependencies.yaml.
def _jar_artifact_impl(ctx):
    jar_name = "%s.jar" % ctx.name
    ctx.download(
        output=ctx.path("jar/%s" % jar_name),
        url=ctx.attr.urls,
        sha256=ctx.attr.sha256,
        executable=False
    )
    src_name="%s-sources.jar" % ctx.name
    srcjar_attr=""
    has_sources = len(ctx.attr.src_urls) != 0
    if has_sources:
        ctx.download(
            output=ctx.path("jar/%s" % src_name),
            url=ctx.attr.src_urls,
            sha256=ctx.attr.src_sha256,
            executable=False
        )
        srcjar_attr ='\n    srcjar = ":%s",' % src_name

    build_file_contents = """
package(default_visibility = ['//visibility:public'])
java_import(
    name = 'jar',
    tags = ['maven_coordinates={artifact}'],
    jars = ['{jar_name}'],{srcjar_attr}
)
filegroup(
    name = 'file',
    srcs = [
        '{jar_name}',
        '{src_name}'
    ],
    visibility = ['//visibility:public']
)\n""".format(artifact = ctx.attr.artifact, jar_name = jar_name, src_name = src_name, srcjar_attr = srcjar_attr)
    ctx.file(ctx.path("jar/BUILD"), build_file_contents, False)
    return None

jar_artifact = repository_rule(
    attrs = {
        "artifact": attr.string(mandatory = True),
        "sha256": attr.string(mandatory = True),
        "urls": attr.string_list(mandatory = True),
        "src_sha256": attr.string(mandatory = False, default=""),
        "src_urls": attr.string_list(mandatory = False, default=[]),
    },
    implementation = _jar_artifact_impl
)

def jar_artifact_callback(hash):
    src_urls = []
    src_sha256 = ""
    source=hash.get("source", None)
    if source != None:
        src_urls = [source["url"]]
        src_sha256 = source["sha256"]
    jar_artifact(
        artifact = hash["artifact"],
        name = hash["name"],
        urls = [hash["url"]],
        sha256 = hash["sha256"],
        src_urls = src_urls,
        src_sha256 = src_sha256
    )
    native.bind(name = hash["bind"], actual = hash["actual"])


def list_dependencies():
    return [
    {"artifact": "org.scala-lang:scala-library:2.12.10", "lang": "java", "sha1": "3509860bc2e5b3da001ed45aca94ffbe5694dbda", "sha256": "0a57044d10895f8d3dd66ad4286891f607169d948845ac51e17b4c1cf0ab569d", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-library/2.12.10/scala-library-2.12.10.jar", "source": {"sha1": "686bb459f3026f14165373324d943a4cac6959c2", "sha256": "a6f873aeb9b861848e0d0b4ec368a3f1682e33bdf11a82ce26f0bfe5fb197647", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/scala-lang/scala-library/2.12.10/scala-library-2.12.10-sources.jar"} , "name": "org_scala_lang_scala_library", "actual": "@org_scala_lang_scala_library//jar", "bind": "jar/org/scala_lang/scala_library"},
    {"artifact": "org.typelevel:cats-core_2.12:2.1.1", "lang": "scala", "sha1": "cf3f2987ad78eff150443414a9dd5ca58fe4b56c", "sha256": "1792e4fd70ffa36ee64312500dd81fb11c0b02cde9fb6766d78ad189b1efbb13", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-core_2.12/2.1.1/cats-core_2.12-2.1.1.jar", "source": {"sha1": "9826edc19e726f74ba82cc8be397b62161c938ea", "sha256": "43428e50f03c1142ba5ca75406b1eb6a3ec8efc0a17a725fe0dec9bcb983d95f", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-core_2.12/2.1.1/cats-core_2.12-2.1.1-sources.jar"} , "name": "org_typelevel_cats_core_2_12", "actual": "@org_typelevel_cats_core_2_12//jar:file", "bind": "jar/org/typelevel/cats_core_2_12"},
    {"artifact": "org.typelevel:cats-effect_2.12:2.1.1", "lang": "scala", "sha1": "d3175ae092ba52070085bff0cbca7370176a9d18", "sha256": "a0a067af9eb9a7c1b9ac60cdcc56ea9361f5b3e9fcebd008256af75ab86f5593", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-effect_2.12/2.1.1/cats-effect_2.12-2.1.1.jar", "source": {"sha1": "570167b015b6a77c8d3279f37196debb9025bc46", "sha256": "6ad5f25a6eddb6c4c784fc83c1df628efb729a934ae1621d560263a8a1d57c53", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-effect_2.12/2.1.1/cats-effect_2.12-2.1.1-sources.jar"} , "name": "org_typelevel_cats_effect_2_12", "actual": "@org_typelevel_cats_effect_2_12//jar:file", "bind": "jar/org/typelevel/cats_effect_2_12"},
    {"artifact": "org.typelevel:cats-kernel_2.12:2.1.1", "lang": "scala", "sha1": "d614d5963cae35f5fe9aad46aa358627574f5b08", "sha256": "f1495a7eee9295b5f5913cb53cb2585e45c372b4ed076a9f338f1409a3099cfb", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-kernel_2.12/2.1.1/cats-kernel_2.12-2.1.1.jar", "source": {"sha1": "c81a597c2b460a0fba6d982bbb9f000e9506e749", "sha256": "20ff331459ab0911338cde12d8fcf7ecef914aa31a436fe24e05a7773c4f4553", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-kernel_2.12/2.1.1/cats-kernel_2.12-2.1.1-sources.jar"} , "name": "org_typelevel_cats_kernel_2_12", "actual": "@org_typelevel_cats_kernel_2_12//jar:file", "bind": "jar/org/typelevel/cats_kernel_2_12"},
    {"artifact": "org.typelevel:cats-macros_2.12:2.1.1", "lang": "scala", "sha1": "4bfc1762be22eabd3007308b1b85098d25958920", "sha256": "2f1c605f1ab0e313f0e9115ab0a578072774055d4a8e47d1062c83981e6b0c2c", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-macros_2.12/2.1.1/cats-macros_2.12-2.1.1.jar", "source": {"sha1": "db668436ed4cb68b6967f5d4bdb3f090b30159de", "sha256": "b76742a6d424d2ca7635875bb49a3e2150b0b035e0dcf71c6ffddef81d063872", "repository": "https://repo.maven.apache.org/maven2/", "url": "https://repo.maven.apache.org/maven2/org/typelevel/cats-macros_2.12/2.1.1/cats-macros_2.12-2.1.1-sources.jar"} , "name": "org_typelevel_cats_macros_2_12", "actual": "@org_typelevel_cats_macros_2_12//jar:file", "bind": "jar/org/typelevel/cats_macros_2_12"},
    ]

def maven_dependencies(callback = jar_artifact_callback):
    for hash in list_dependencies():
        callback(hash)
