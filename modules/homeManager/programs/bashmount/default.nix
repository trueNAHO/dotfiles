{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.bashmount.enable =
    lib.mkEnableOption "bashmount";

  config = lib.mkIf config.modules.homeManager.programs.bashmount.enable {
    programs.bashmount.enable =
      lib.info
      "Add 'services.udisks2.enable = true;' to the system configuration for '${pkgs.bashmount.pname}' and 'udiskctl' to work: https://nix-community.github.io/home-manager/options.html#opt-services.udiskie.enable"
      true;
  };
}
