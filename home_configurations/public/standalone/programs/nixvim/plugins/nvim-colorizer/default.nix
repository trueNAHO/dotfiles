lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration
"nvim-colorizer"
{
  config.modules.programs.nixvim = {
    enable = true;
    plugins.nvim-colorizer.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/nvim-colorizer
  ];
}
