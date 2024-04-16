lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "acpi" {
  config.modules.homeManager.home.packages.acpi.enable = true;
  imports = [../../../../../../../modules/homeManager/home/packages/acpi];
}
