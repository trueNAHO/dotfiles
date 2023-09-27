{pkgs, ...}: {
  home.shellAliases.b = pkgs.bat.pname;
  programs.bat.enable = true;
}
