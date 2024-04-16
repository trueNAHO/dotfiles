lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "imv" {
  config.modules.homeManager.programs.imv.enable = true;
  imports = [../../../../../../modules/homeManager/programs/imv];
}
