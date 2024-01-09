{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.nixpkgs.config.allowUnfree.enable =
    lib.mkEnableOption "allowUnfree";

  config = {
    nixpkgs.config.allowUnfree =
      lib.info
      "nixpkgs.config.allowUnfree = ${toString config.modules.homeManager.nixpkgs.config.allowUnfree.enable};"
      config.modules.homeManager.nixpkgs.config.allowUnfree.enable;
  };
}
