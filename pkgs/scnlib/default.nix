{ lib
, stdenv
, fetchFromGitHub
, cmake
, fast-float
, enableShared ? !stdenv.hostPlatform.isStatic
}:

stdenv.mkDerivation rec {
  pname = "scnlib";
  version = "3.0.1";

  src = fetchFromGitHub {
    owner = "eliaskosunen";
    repo = "scnlib";
    rev = "v${version}";
    sha256 = "sha256-m8HYolwsf19O6Ye7mLSsNyuXEQlC7DoKw9TYuJkPqjM=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ fast-float ];

  cmakeFlags = [
    "-DSCN_TESTS=OFF"
    "-DSCN_BENCHMARKS=OFF"
    "-DSCN_EXAMPLES=OFF"
    "-DSCN_USE_EXTERNAL_FAST_FLOAT=ON"
    "-DBUILD_SHARED_LIBS=${if enableShared then "ON" else "OFF"}"
  ];

  meta = with lib; {
    description = "Modern C++ library for replacing scanf and std::istream";
    homepage = "https://scnlib.readthedocs.io/";
    license = licenses.asl20;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}
