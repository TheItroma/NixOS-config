{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib.types) bool int float str listOf submodule path attrs;
  inherit (lib) ElemAt mkOption;

  mkOpt = options:
    lib.mkOption {
      type = ElemAt options 0;
      default = ElemAt options 1;
    };


  dwlC = lib.readFile "./../../dwl.c";

  # DISCLAIMER : Use of chatgpt for regex

  CTypedefStructMatch = name:
    "typedef\s+struct\s*\{([\s\S]*?)\}\s*${name}\s*;";

  CVarMapper = [
    ["char\s*\*" str]
    ["\bfloat\b" float]
    ["\bint\b" int]
    ["\benum\b" int]
  ];

  CVarToOption = line:
    
in {
  monitors = mkOptionFromC "";
}

typedef struct {
	const char *name;
	float mfact;
	int nmaster;
	float scale;
	const Layout *lt;
	enum wl_output_transform rr;
	int x, y;
} MonitorRule;

monitors = {
  type = listOf (submodule {
    options = {
      name = mkOpt [str builtins.null];
      mfact = mkOpt [float 0.5];
      nmaster = mkOpt [int 1];
      scale = mkOpt [int 2];
      layout = mkOpt [int 0];
      x = mkOpt [int (-1)];
      y = mkOpt [int (-1)];
    };
  });
};


