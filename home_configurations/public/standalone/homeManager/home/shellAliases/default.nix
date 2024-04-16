lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "shellAliases" {
  config.modules.homeManager.home.shellAliases.enable = true;
  imports = [../../../../../../modules/homeManager/home/shellAliases];
}
