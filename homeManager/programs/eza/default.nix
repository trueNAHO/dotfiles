{pkgs, ...}: {
  home.shellAliases = {
    l = "${pkgs.eza.pname}";
    la = "${pkgs.eza.pname} --all";
    ll = "${pkgs.eza.pname} --long";
    lla = "${pkgs.eza.pname} --all --long";
  };

  programs.eza.enable = true;
}
