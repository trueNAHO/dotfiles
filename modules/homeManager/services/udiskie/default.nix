{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.services.udiskie.enable =
    lib.mkEnableOption "udiskie";

  config = lib.mkIf config.modules.homeManager.services.udiskie.enable {
    services.udiskie.enable =
      import ../../../../lib/modules/lib_info_nixos {
        inherit lib;

        documentation = "https://nix-community.github.io/home-manager/options.xhtml#opt-services.udiskie.enable";
        literalExpression = "services.udisks2.enable = true;";
        src = "modules.homeManager.services.udiskie, udiskctl";
      }
      true;
  };
}
