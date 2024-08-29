{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "mdspan";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "kokkos";
    repo = "mdspan";
    rev = "98a12b01b51b250d4f510878604d4047496d845d";
    sha256 = "sha256-Hmg+p6xaMyh/gz1SP9Z+GNelm03pQU7lytG9stAhe7Y=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DCMAKE_CXX_STANDARD=20"
    "-DMDSPAN_CXX_STANDARD=20"
    "-DMDSPAN_ENABLE_TESTS=OFF"
    "-DMDSPAN_ENABLE_BENCHMARKS=OFF"
  ];

  meta = with lib; {
    description = "Header-only implementation of ISO-C++ proposal P0009 (non-owning multi-dimensional array)";
    homepage = "https://github.com/kokkos/mdspan";
    license = licenses.bsd3;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}
