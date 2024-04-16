lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "fidget" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.fidget.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/fidget
  ];
}
