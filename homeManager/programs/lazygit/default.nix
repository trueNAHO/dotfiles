{pkgs, ...}: {
  home.shellAliases.lg = pkgs.lazygit.pname;

  programs = {
    git.enable = true;

    lazygit = {
      enable = true;
      settings.git.branchLogCmd = "${pkgs.git.pname} log --color=always --decorate --graph --oneline {{branchName}}";
    };
  };
}
