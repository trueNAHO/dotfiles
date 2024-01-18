{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.taskwarrior.enable =
    lib.mkEnableOption "taskwarrior";

  config = lib.mkIf config.modules.homeManager.programs.taskwarrior.enable {
    home.shellAliases.tk = pkgs.taskwarrior.meta.mainProgram;

    programs.taskwarrior = {
      # TODO: https://github.com/danth/stylix/pull/223
      colorTheme = "no-color";

      enable = true;
    };
  };
}
