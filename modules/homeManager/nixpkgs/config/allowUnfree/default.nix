{
  config,
  lib,
  ...
}: let
  module = "modules.homeManager.nixpkgs.config.allowUnfree";
in {
  options.modules.homeManager.nixpkgs.config.allowUnfree.enable =
    lib.mkEnableOption module;

  config = let
    cfg = config.modules.homeManager.nixpkgs.config.allowUnfree;
    string = "'nixpkgs.config.allowUnfree = ${toString cfg.enable};'";
  in {
    home.activation.${module} =
      lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.printf module string;

    nixpkgs.config.allowUnfree = lib.info string cfg.enable;
  };
}
