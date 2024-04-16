lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration
"rainbow-delimiters"
{
  config.modules.programs.nixvim = {
    enable = true;
    plugins.rainbow-delimiters.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/rainbow-delimiters
  ];
}
