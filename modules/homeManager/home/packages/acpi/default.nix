{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.acpi.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.acpi";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.acpi.enable {
    home.packages = [pkgs.acpi];
  };
}
