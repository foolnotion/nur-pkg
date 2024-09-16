{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "mdspan";
  version = "0.6.0";

  src = fetchFromGitHub {
    owner = "kokkos";
    repo = "mdspan";
    rev = "92a12979e929b5921809e69b27cbd9d3796fa087";
    sha256 = "sha256-nuOkh636tyY0DfUcp1FGHstgKG66PnebTdaDBvAgdwo=";
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DCMAKE_CXX_STANDARD=20"
    "-DMDSPAN_CXX_STANDARD=20"
    "-DMDSPAN_ENABLE_TESTS=OFF"
    "-DMDSPAN_ENABLE_BENCHMARKS=OFF"
    "-DMDSPAN_INSTALL_STDMODE_HEADERS=ON"
  ];

  meta = with lib; {
    description = "Header-only implementation of ISO-C++ proposal P0009 (non-owning multi-dimensional array)";
    homepage = "https://github.com/kokkos/mdspan";
    license = licenses.bsd3;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}
