{
  config,
  lib,
  ...
}: {
  options.dotfiles.homeManager.programs.taskwarrior.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.taskwarrior";

  config = lib.mkIf config.dotfiles.homeManager.programs.taskwarrior.enable {
    home.shellAliases.tk = lib.getExe config.programs.taskwarrior.package;

    programs.taskwarrior = {
      # TODO: https://github.com/danth/stylix/pull/223
      colorTheme = "no-color";

      config.urgency = {
        active.coefficient = 1;
        age.coefficient = 0;
        annotations.coefficient = 0;
        blocked.coefficient = -2;
        blocking.coefficient = 0;
        due.coefficient = 4;
        project.coefficient = 0;
        scheduled.coefficient = 1;
        tags.coefficient = 0;

        uda.priority = {
          H.coefficient = 4;
          L.coefficient = -2;
          M.coefficient = 2;
        };

        user.tag.next.coefficient = 6;
        waiting.coefficient = -1;
      };

      enable = true;
    };
  };
}
