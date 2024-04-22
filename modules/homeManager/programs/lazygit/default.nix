{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../git];

  options.modules.homeManager.programs.lazygit.enable =
    lib.mkEnableOption "modules.homeManager.programs.lazygit";

  config = lib.mkIf config.modules.homeManager.programs.lazygit.enable {
    modules.homeManager.programs.git.enable = true;

    home.shellAliases.lg = lib.getExe config.programs.lazygit.package;

    programs.lazygit = {
      enable = true;

      settings = {
        git = {
          autoFetch = false;

          branchLogCmd = lib.concatStringsSep " " [
            (lib.getExe pkgs.git)
            "log"
            "--color=always"
            "--decorate"
            "--graph"
            "--oneline"
            "{{branchName}}"
          ];
        };

        # Due to the following Lazygit error, the package version is not locked
        # with 'config.home.sessionVariables.EDITOR':
        #
        #     bash: line 1: vim: command not found
        #
        # This error is most likely caused by the slashes ('/') in the command
        # name.
        os.editPreset = pkgs.neovim.meta.mainProgram;
      };
    };
  };
}
