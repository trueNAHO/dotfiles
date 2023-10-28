{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.tree.enable =
    lib.mkEnableOption "tree";

  config = lib.mkIf config.modules.homeManager.home.packages.tree.enable {
    home = {
      packages = [pkgs.tree];
      shellAliases.t = "${pkgs.tree.pname} -C";
    };
  };
}
