{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../git];
  options.modules.programs.lazygit.enable = lib.mkEnableOption "lazygit";

  config = lib.mkIf config.modules.programs.lazygit.enable {
    home.shellAliases.lg = pkgs.lazygit.pname;
    modules.programs.git.enable = true;

    programs.lazygit = {
      enable = true;
      settings.git.branchLogCmd = "${pkgs.git.pname} log --color=always --decorate --graph --oneline {{branchName}}";
    };
  };
}
