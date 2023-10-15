{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.shellAliases.enable =
    lib.mkEnableOption "global shell aliases";

  config = lib.mkIf config.modules.homeManager.home.shellAliases.enable {
    home.shellAliases = {
      c = "cd";
      cal = "${pkgs.util-linux.outPath}/bin/cal --monday";
    };
  };
}
