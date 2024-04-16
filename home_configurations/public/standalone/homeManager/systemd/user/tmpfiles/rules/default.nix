lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "rules" {
  config.modules.homeManager.systemd.user.tmpfiles.rules.enable = true;

  imports = [
    ../../../../../../../../modules/homeManager/systemd/user/tmpfiles/rules
  ];
}
