{pkgs, ...}: {
  home.shellAliases = {
    c = "cd";
    cal = "${pkgs.util-linux.outPath}/bin/cal --monday";
  };
}
