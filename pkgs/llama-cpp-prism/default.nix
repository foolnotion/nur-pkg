{
  lib,
  autoAddDriverRunpath,
  cmake,
  fetchFromGitHub,
  installShellFiles,
  stdenv,

  rocmPackages ? { },
  # 6900 XT (RDNA2) by default; override per-machine, e.g. the 9060 XT (RDNA4)
  # needs its own target - confirm with `rocminfo | grep gfx` on that box
  # rather than trusting a guess here.
  rocmGpuTargets ? [ "gfx1030" ],

  fetchNpmDeps,
  nodejs_latest,
  npmHooks,

  pkg-config,
  openssl,
  ninja,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "llama-cpp-prism";
  # Tracks the `prism` branch HEAD, not a stable release - bump `rev` by hand
  # (`git ls-remote https://github.com/PrismML-Eng/llama.cpp.git prism`) and
  # update `hash` from the fetcher's mismatch error.
  version = "unstable-2026-07-15";

  outputs = [
    "out"
    "dev"
  ];

  src = fetchFromGitHub {
    owner = "PrismML-Eng";
    repo = "llama.cpp";
    rev = "62061f91088281e65071cc38c5f69ee95c39f14e";
    hash = "sha256-zLxB5UKnCTCw/okB+L8u1VtM1o2yVjVYTlTBgL/BsaM=";
    leaveDotGit = true;
    postFetch = ''
      git -C "$out" rev-parse --short HEAD > $out/COMMIT
      find "$out" -name .git -print0 | xargs -0 rm -rf
    '';
  };

  nativeBuildInputs = [
    cmake
    installShellFiles
    ninja
    nodejs_latest
    npmHooks.npmConfigHook
    pkg-config
    autoAddDriverRunpath
    rocmPackages.clr
  ];

  buildInputs = [
    rocmPackages.clr
    rocmPackages.hipblas
    rocmPackages.rocblas
    openssl
  ];

  npmRoot = "tools/ui";
  npmDepsHash = "sha256-pjdbI6NcZRlJVd62xhgbLhWrwFYwgsIwjORqvo1+VD8=";
  npmDeps = fetchNpmDeps {
    name = "${finalAttrs.pname}-${finalAttrs.version}-npm-deps";
    inherit (finalAttrs) src patches;
    preBuild = ''
      pushd ${finalAttrs.npmRoot}
    '';
    hash = finalAttrs.npmDepsHash;
  };

  patches = [ ];

  preConfigure = ''
    prependToVar cmakeFlags "-DLLAMA_BUILD_COMMIT:STRING=$(cat COMMIT)"
    pushd ${finalAttrs.npmRoot}
    npm run build
    popd
  '';

  cmakeFlags = [
    (lib.cmakeBool "GGML_NATIVE" false)
    (lib.cmakeBool "LLAMA_BUILD_EXAMPLES" false)
    (lib.cmakeBool "LLAMA_BUILD_SERVER" true)
    (lib.cmakeBool "LLAMA_BUILD_TESTS" false)
    (lib.cmakeBool "LLAMA_OPENSSL" true)
    (lib.cmakeBool "BUILD_SHARED_LIBS" true)
    (lib.cmakeBool "GGML_HIP" true)
    (lib.cmakeFeature "CMAKE_HIP_COMPILER" "${rocmPackages.clr.hipClangPath}/clang++")
    (lib.cmakeFeature "CMAKE_HIP_ARCHITECTURES" (builtins.concatStringsSep ";" rocmGpuTargets))
  ];

  postInstall = ''
    mkdir -p $out/include
    cp $src/include/llama.h $out/include/
  '';

  doCheck = false;

  meta = {
    description = "PrismML fork of llama.cpp with Bonsai hybrid-attention/ternary kernels, ROCm build";
    homepage = "https://github.com/PrismML-Eng/llama.cpp";
    license = lib.licenses.mit;
    mainProgram = "llama-cli";
    platforms = lib.platforms.linux;
  };
})
