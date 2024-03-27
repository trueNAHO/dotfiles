{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.nixpkgs.config.allowUnfree.enable =
    lib.mkEnableOption "allowUnfree";

  config = let
    cfg = config.modules.homeManager.nixpkgs.config.allowUnfree;
    string = "nixpkgs.config.allowUnfree = ${toString cfg.enable};";
  in {
    home.activation."modules.homeManager.nixpkgs.config.allowUnfree" =
      import
      ../../../../../lib/modules/lib_hm_dag_entry_after_write_boundary_printf {
        inherit string lib;
        src = "modules.homeManager.nixpkgs.config.allowUnfree";
      };

    nixpkgs.config.allowUnfree = lib.info string cfg.enable;
  };
}
