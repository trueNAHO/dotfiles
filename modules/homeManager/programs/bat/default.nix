{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.bat.enable =
    lib.mkEnableOption "modules.homeManager.programs.bat";

  config = lib.mkIf config.modules.homeManager.programs.bat.enable {
    # TODO: Add upstream 'config.programs.bat.finalPackage' option.
    home.shellAliases.b = lib.getExe pkgs.bat;

    programs.bat.enable = true;
  };
}
