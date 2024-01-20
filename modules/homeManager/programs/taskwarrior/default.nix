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

      config.urgency = {
        active.coefficient = 1;
        age.coefficient = 0;
        annotations.coefficient = 0;
        blocked.coefficient = -2;
        blocking.coefficient = 0;
        due.coefficient = 6;
        project.coefficient = 0;
        scheduled.coefficient = 1;
        tags.coefficient = 0;

        uda.priority = {
          H.coefficient = 6;
          L.coefficient = 2;
          M.coefficient = 4;
        };

        user.tag.next.coefficient = 8;
        waiting.coefficient = -1;
      };

      enable = true;
    };
  };
}
