
{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "quickcpplib";
  version = "0.1.0.0";

  src = fetchFromGitHub {
    owner = "ned14";
    repo = "quickcpplib";
    rev = "568e1811edf0f47caafbeb62a4f9fe4e885a0f96";
    sha256 = "sha256-vR5m8AQpP2NO/w1jf8YlvdiuKnGvLoKWzzy/6W7x0NE=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ cmake ];

  meta = with lib; {
    description = "Library to eliminate all the tedious hassle when making state-of-the-art C++ 14 - 23 libraries.";
    homepage = "https://github.com/ned14/quickcpplib";
    license = licenses.asl20;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}
