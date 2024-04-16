lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "keymaps" {
  config.modules.programs.nixvim = {
    enable = true;
    keymaps.enable = true;
  };

  imports = [
    ../../../../../../modules/programs/nixvim
    ../../../../../../modules/programs/nixvim/keymaps
  ];
}
