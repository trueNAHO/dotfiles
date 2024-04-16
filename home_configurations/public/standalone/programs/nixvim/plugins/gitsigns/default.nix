lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "gitsigns" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.gitsigns.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/gitsigns
  ];
}
