{
  config,
  lib,
  ...
}: let
  module = "dotfiles.homeManager.nixpkgs.config.allowUnfree";
in {
  options.dotfiles.homeManager.nixpkgs.config.allowUnfree.enable =
    lib.mkEnableOption module;

  config = let
    cfg = config.dotfiles.homeManager.nixpkgs.config.allowUnfree;
    string = "'nixpkgs.config.allowUnfree = ${toString cfg.enable};'";
  in {
    home.activation.${module} =
      lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.printf module string;

    nixpkgs.config.allowUnfree = lib.info string cfg.enable;
  };
}
