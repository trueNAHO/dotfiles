{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../git];

  options.modules.homeManager.programs.lazygit.enable =
    lib.mkEnableOption "lazygit";

  config = lib.mkIf config.modules.homeManager.programs.lazygit.enable {
    home.shellAliases.lg = pkgs.lazygit.pname;
    modules.homeManager.programs.git.enable = true;

    programs.lazygit = {
      enable = true;
      settings.git = {
        autoFetch = false;
        branchLogCmd = "${pkgs.git.pname} log --color=always --decorate --graph --oneline {{branchName}}";
      };
    };
  };
}
