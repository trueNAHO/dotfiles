{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.tree.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.tree";

  config = lib.mkIf config.modules.homeManager.home.packages.tree.enable {
    home = {
      packages = [pkgs.tree];

      # The local 'home.shellAliases' variables are not replaced with the
      # arguably simpler
      #
      #     home.shellAliases.<ALIAS_2> = config.home.shellAliases.<ALIAS_1>;
      #
      # statement to prevent the following error:
      #
      #     error: infinite recursion encountered
      shellAliases = let
        tree = "${pkgs.tree.pname} -C";
      in {
        t = tree;
        tg = "${tree} --gitignore";
      };
    };
  };
}
