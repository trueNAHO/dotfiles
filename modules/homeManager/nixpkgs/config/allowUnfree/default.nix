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
    home.activation = {
      ${module} =
        import
        ../../../../../lib/modules/lib_hm_dag_entry_before_write_boundary_printf
        {
          inherit lib string;
          src = module;
        };
    };

    nixpkgs.config.allowUnfree = lib.info string cfg.enable;
  };
}
