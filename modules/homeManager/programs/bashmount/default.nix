{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.bashmount.enable =
    lib.mkEnableOption "bashmount";

  config = lib.mkIf config.modules.homeManager.programs.bashmount.enable {
    home.activation.udiskie =
      import
      ../../../../lib/modules/lib_hm_dag_entry_after_write_boundary_nixos {
        inherit lib;

        documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-services.udiskie.enable";
        literalExpression = "services.udisks2.enable = true;";
        src = "modules.homeManager.programs.bashmount, udiskctl";
      };

    programs.bashmount.enable = true;
  };
}
