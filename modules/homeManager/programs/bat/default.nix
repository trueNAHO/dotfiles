{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.programs.bat.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.bat";

  config = lib.mkIf config.dotfiles.homeManager.programs.bat.enable {
    # TODO: Add upstream 'config.programs.bat.finalPackage' option.
    home.shellAliases.b = lib.getExe pkgs.bat;

    programs.bat.enable = true;
  };
}
