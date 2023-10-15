{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.bat.enable = lib.mkEnableOption "bat";

  config = lib.mkIf config.modules.homeManager.programs.bat.enable {
    home.shellAliases.b = pkgs.bat.pname;
    programs.bat.enable = true;
  };
}
