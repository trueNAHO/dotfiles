{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.nixpkgs.config.allowUnfree.enable =
    lib.mkEnableOption "allowUnfree";

  config = let
    cfg = config.modules.homeManager.nixpkgs.config.allowUnfree;
    string = "'nixpkgs.config.allowUnfree = ${toString cfg.enable};'";
  in {
    home.activation = let
      src = "modules.homeManager.nixpkgs.config.allowUnfree";
    in {
      ${src} =
        import
        ../../../../../lib/modules/lib_hm_dag_entry_before_write_boundary_printf {
          inherit lib src string;
        };
    };

    nixpkgs.config.allowUnfree = lib.info string cfg.enable;
  };
}
