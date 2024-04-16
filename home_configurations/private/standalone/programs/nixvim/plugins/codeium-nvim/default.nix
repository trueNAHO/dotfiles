lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "codeium-nvim" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.codeium-nvim.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/codeium-nvim
  ];
}
