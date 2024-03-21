{ lib, stdenv, fetchFromGitHub, cmake }:
let
  # use a fork of libdwarf with proper cmake support (needed by cpptrace)
  libdwarf_ = stdenv.mkDerivation {
    pname = "libdwarf";
    version = "0.9.1";

    src = fetchFromGitHub {
      owner = "jeremy-rifkin";
      repo = "libdwarf-code";
      rev = "520e20185262f96c9580cab157307b0890fc2c66";
      hash = "sha256-AlrdgUFPC9wQp851yHdwmCD/6dRvH/EphKCercO4wbs=";
    };

    nativeBuildInputs = [ cmake ];

    meta = {
      homepage = "https://github.com/jeremy-rifkin/libdwarf-code";
      platforms = lib.platforms.unix;
      license = lib.licenses.lgpl21Plus;
      maintainers = [ lib.maintainers.atry ];
    };
  };
in
stdenv.mkDerivation rec {
  pname = "cpptrace";
  version = "0.5.1";

  src = fetchFromGitHub {
    owner = "jeremy-rifkin";
    repo = "cpptrace";
    rev = "v${version}";
    hash = "sha256-RKmU9kl/sUu7Yu8E9RDV+xbb7X82b6m+0Rqtn7mo74w=";
  };

  nativeBuildInputs = [ cmake ];

  buildInputs = [ libdwarf_ ];

  cmakeFlags = [
    "-DCPPTRACE_GET_SYMBOLS_WITH_LIBDWARF=1"
    "-DCPPTRACE_USE_EXTERNAL_LIBDWARF=1"
  ];

  meta = with lib; {
    description = "Simple, portable, and self-contained C++ stacktrace library supporting C++11 and greater";
    homepage = "https://github.com/jeremy-rifkin/cpptrace";
    license = licenses.mit;
    platforms = platforms.all;
    #maintainers = with maintainers; [ foolnotion ];
  };
}
