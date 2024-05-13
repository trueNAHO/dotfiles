{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.tree.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.tree";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.tree.enable {
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
      #
      # TODO: Patch an upstream fix.
      shellAliases = let
        tree = "${lib.getExe pkgs.tree} -C";
      in {
        t = tree;
        tg = "${tree} --gitignore";
      };
    };
  };
}
