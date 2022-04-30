
{ lib, stdenv, fetchFromGitHub, cmake }:

stdenv.mkDerivation rec {
  pname = "quickcpplib";
  version = "0.1.0.0";

  src = builtins.fetchGit {
    url = "http://github.com/ned14/quickcpplib";
    rev = "ef0fe8ecf9951717b63b27447ddcaf5cc8eed6e2";
    submodules = true;
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