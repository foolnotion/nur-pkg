{ lib, stdenv, fetchFromGitHub, cmake
, enableShared ? !stdenv.hostPlatform.isStatic }:

stdenv.mkDerivation rec {
  pname = "sleef";
  version = "3.7";

  src = fetchFromGitHub {
    owner = "shibatch";
    repo = "sleef";
    rev = "${version}";
    sha256 = "sha256-bzk80BRpTKYrhKKNtF/la1cO04Yn0zQ5DrwpkxULPrk=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TYPE=Release"
    "-DSLEEF_DISABLE_OPENMP=ON"
    "-DBUILD_SHARED_LIBS=${if enableShared then "ON" else "OFF"}"
    "-DCMAKE_C_FLAGS_RELEASE=${if stdenv.hostPlatform.isx86_64 then "-march=x86-64-v3" else ""}"
  ];

  meta = with lib; {
    description = "SIMD Library for Evaluating Elementary Functions";
    homepage = "https://sleef.org";
    license = licenses.boost;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}

