{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.acpi.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.acpi";

  config = lib.mkIf config.modules.homeManager.home.packages.acpi.enable {
    home.packages = [pkgs.acpi];
  };
}
