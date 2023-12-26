{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.nixpkgs.config.allowUnfree.enable =
    lib.mkEnableOption "allowUnfree";

  config = {
    nixpkgs.config.allowUnfree = config.modules.homeManager.nixpkgs.config.allowUnfree.enable;
  };
}
