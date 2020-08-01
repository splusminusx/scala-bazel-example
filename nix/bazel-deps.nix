{ stdenv, buildBazelPackage, lib, fetchFromGitHub, git, jre, makeWrapper }:	

buildBazelPackage rec {	
  name = "bazel-deps-${version}";	
  version = "2020-03-04";	

  meta = with stdenv.lib; {	
    homepage = "https://github.com/johnynek/bazel-deps";	
    description = "Generate bazel dependencies for maven artifacts";	
    license = licenses.mit;	
    maintainers = [ maintainers.uri-canva ];	
    platforms = platforms.all;	
    #broken = true; # global variable '_common_attrs_for_plugin_bootstrapping' is referenced before assignment.	
  };	

  src = fetchFromGitHub {	
    owner = "johnynek";	
    repo = "bazel-deps";	
    rev = "dbd90f155e45e0b2529999d0b74ea65b49e6fb07";	
    sha256 = "01363m8fmdahl7ysaiwi5rr4gc6wkj9xyq2sydclib0cyq28gjbz";	
  };	

  bazelTarget = "//src/scala/com/github/johnynek/bazel_deps:parseproject_deploy.jar";	

  buildInputs = [ git makeWrapper ];	

  fetchAttrs = {	
    sha256 = "0j3j7bji7x7hilr9pngshz5ykgq10biizzjs7nszpyf79gf13nk5";	
  };	

  buildAttrs = {	
    installPhase = ''	
      mkdir -p $out/bin/bazel-bin/src/scala/com/github/johnynek/bazel_deps	
      cp gen_maven_deps.sh $out/bin	
      wrapProgram "$out/bin/gen_maven_deps.sh" --set JAVA_HOME "${jre}" --prefix PATH : ${lib.makeBinPath [ jre ]}	
      cp bazel-bin/src/scala/com/github/johnynek/bazel_deps/parseproject_deploy.jar $out/bin/bazel-bin/src/scala/com/github/johnynek/bazel_deps	
    '';	
  };	
}
