{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.nixpkgs.config.allowUnfree.enable =
    lib.mkEnableOption "allowUnfree";

  config = let
    cfg = config.modules.homeManager.nixpkgs.config.allowUnfree;
  in {
    nixpkgs.config.allowUnfree =
      lib.info
      "nixpkgs.config.allowUnfree = ${toString cfg.enable};"
      cfg.enable;
  };
}
