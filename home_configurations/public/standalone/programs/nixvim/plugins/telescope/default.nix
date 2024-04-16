lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "telescope" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.telescope.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/telescope
  ];
}
