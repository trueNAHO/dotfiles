lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration
"password-store"
{
  config.modules.homeManager.programs.password-store.enable = true;
  imports = [../../../../../../modules/homeManager/programs/password-store];
}
