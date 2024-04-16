lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration
"treesitter-context"
{
  config.modules.programs.nixvim = {
    enable = true;
    plugins.treesitter-context.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/treesitter-context
  ];
}
