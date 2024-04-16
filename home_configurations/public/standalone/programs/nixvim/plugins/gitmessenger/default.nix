lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "gitmessenger" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.gitmessenger.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/gitmessenger
  ];
}
