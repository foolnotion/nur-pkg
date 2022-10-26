{ lib, stdenv, fetchFromGitHub, cmake, fmt_8 }:

stdenv.mkDerivation rec {
  pname = "cpp-lazy";
  version = "5.1.1";

  src = fetchFromGitHub {
    owner = "MarcDirven";
    repo = "cpp-lazy";
    rev = "${version}";
    sha256 = "sha256-aWxBwWpVtIrCpZp7XhaAtTwz4IDe100pndHtCycYUf4=";
  };

  nativeBuildInputs = [ cmake ];
  buildInputs = [ fmt_8 ];

  cmakeFlags = [
    "-DCPP-LAZY_USE_INSTALLED_FMT=ON"
  ];

  meta = with lib; {
    description = "A fast C++11/14/17/20 header only library for lazy evaluation and function tools";
    homepage = "https://github.com/MarcDirven/cpp-lazy";
    license = licenses.mit;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}