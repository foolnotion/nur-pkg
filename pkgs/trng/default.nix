{ lib, stdenv, cmake }:

stdenv.mkDerivation rec {
  pname = "trng";
  version = "4.24";

  src = builtins.fetchGit {
    url = "https://github.com/rabauke/trng4.git";
    rev = "efdb3cfdb589a1f34ce4dfde85a8a068451018e3";
    submodules = true;
  };

  nativeBuildInputs = [ cmake ];

  cmakeFlags = [
    "-DCMAKE_BUILD_TESTING=0"
    "-DBUILD_SHARED_LIBS=0"
  ];


  meta = with lib; {
    description = "Modern C++ pseudo random number generator library";
    homepage = "https://github.com/rabauke/trng4";
    license = licenses.bsd3;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}
