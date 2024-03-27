{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.bashmount.enable =
    lib.mkEnableOption "bashmount";

  config = lib.mkIf config.modules.homeManager.programs.bashmount.enable {
    programs.bashmount.enable =
      import ../../../../lib/modules/lib_info_nixos {
        inherit lib;

        documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-services.udiskie.enable";
        literalExpression = "services.udisks2.enable = true;";
        src = "modules.homeManager.programs.bashmount, udiskctl";
      }
      true;
  };
}
