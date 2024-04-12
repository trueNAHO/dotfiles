{
  config,
  inputs,
  lib,
  ...
}: let
  module = "modules.agenix.homeManagerModules.default";
in {
  imports = [inputs.agenix.homeManagerModules.default];

  options.modules.agenix.homeManagerModules.default.enable =
    lib.mkEnableOption module;

  config = lib.mkIf config.modules.agenix.homeManagerModules.default.enable {
    age.identityPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519_age"];

    home.activation = {
      ${module} =
        import
        ../../../../lib/modules/lib_hm_dag_entry_before_write_boundary_printf {
          inherit lib;

          src = module;

          string = let
            keys = builtins.concatStringsSep ", " config.age.identityPaths;
          in "at least one recipient key required: ${keys}";
        };
    };
  };
}
