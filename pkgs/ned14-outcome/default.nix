{ lib, stdenv, fetchFromGitHub, cmake, git, quickcpplib, status-code }:

stdenv.mkDerivation rec {
  pname = "ned14-outcome";
  version = "2.2.8";

  src = fetchFromGitHub {
    owner = "ned14";
    repo = "outcome";
    rev = "5151d2428c8e47b863ea2ae6cc143e1e1d41bc4e";
    hash = "sha256-o/Tm3MQixsDsULQN3cCz2vyyKkS7+3+hmbiUBf++XsY=";
  };

  nativeBuildInputs = [ cmake git quickcpplib status-code ];

  cmakeFlags = [
    "-DPROJECT_IS_DEPENDENCY=ON"
    "-DOUTCOME_BUNDLE_EMBEDDED_QUICKCPPLIB=OFF"
    "-Dquickcpplib_DIR=${quickcpplib}"
    "-DOUTCOME_BUNDLE_EMBEDDED_STATUS_CODE=OFF"
    "-Dstatus-code_DIR=${status-code}"
    "-DOUTCOME_ENABLE_DEPENDENCY_SMOKE_TEST=OFF"  # Leave this always on to test everything compiles
    "-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON"
  ];

  preConfigure = ''
    substituteInPlace CMakeLists.txt --replace-fail find_dependency find_package
  '';

  meta = with lib; {
    description = "C++14 library for reporting and handling function failures";
    homepage = "https://ned14.github.io/outcome/";
    license = licenses.asl20;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}
