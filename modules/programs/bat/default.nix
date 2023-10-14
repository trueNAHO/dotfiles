{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.programs.bat.enable = lib.mkEnableOption "bat";

  config = lib.mkIf config.modules.programs.bat.enable {
    home.shellAliases.b = pkgs.bat.pname;
    programs.bat.enable = true;
  };
}
