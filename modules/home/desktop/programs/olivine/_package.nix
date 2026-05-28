{
  lib,
  stdenv,
  fetchFromGitLab,
  ncurses,
  gnumake,
  makeWrapper,
  customRC ? null,
}:
stdenv.mkDerivation {
  pname = "olivine";
  version = "0.0.1";

  src = fetchFromGitLab {
    owner = "Oglo12";
    repo = "olivine";
    rev = "refs/heads/dev";
    sha256 = "sha256-2QXPP/hyRjPB5c9b8QwvXNSyy5lunfJimlIGMt9l+j4=";

    fetchSubmodules = true;
  };

  nativeBuildInputs = [
    gnumake
    makeWrapper
  ];

  buildInputs = [
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

    # wat da hail is that
    install -D build/olv $out/bin/olv-ncurses
    ln -s $out/bin/olv-ncurses $out/bin/olv

    rcFile=${
      if (customRC != null && builtins.isPath customRC)
      then customRC
      else ./default_rc.lua
    }
    install -D default_rc.lua $out/share/olivine/rc.lua

    cp -r olvstd $out/share/olivine/olvstd/
  '';

  postFixup = ''
    # that too
    wrapProgram $out/bin/olv-ncurses \
      --run "cd $out/share/olivine"
  '';

  meta = {
    homepage = "https://gitlab.com/Oglo12/olivine/-/tree/dev";
    description = "A C and lua text editor where everything is a buffer. No AI";

    longDescription = ''
      A powerful text editor written in C and configured with Lua.
      At the heart of it all, the idea that EVERYTHING is a buffer.
    '';
    license = lib.licenses.gpl1Only;
    maintainers = [];
    mainProgram = "olv";
  };
}
