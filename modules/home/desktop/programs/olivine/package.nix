{
  lib,
  stdenv,
  fetchFromGitLab,
  ncurses,
  lua5_5,
  gnumake,
}:
stdenv.mkDerivation {
  pname = "olivine";
  version = "0.0.1";

  src = fetchFromGitLab {
    owner = "Oglo12";
    repo = "olivine";
    rev = "dev";
    sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";

    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    gnumake
  ];

  buildInputs = [
    lua5_5
    ncurses
  ];

  makeFlags = [
    "PREFIX=$(out)"
    "UI_BACKEND=ncurses"
    "MODE=release"
  ];

  installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/share/olivine
    mkdir -p $out/share/lua/5.5

    install -D olv $out/bin/olv-ncurses
    ln -s $out/bin/olv-ncurses $out/bin/olv

    install -D default_rc.lua $out/share/olivine/rc.lua

    cp -r olvstd $out/share/lua/5.5/
  '';

  meta = {
    homepage = "https://gitlab.com/Oglo12/olivine/-/tree/dev";
    description = "A C and lua text editor where everything is a buffer. No AI";
    longDescription = ''
      A powerful text editor written in C and configured with Lua.
      At the heart of it all, the idea that EVERYTHING is a buffer.
    '';
    license = lib.licenses.gplOnly;
    maintainers = [];
    mainProgram = "olv";
  };
}
