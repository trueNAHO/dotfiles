lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "trouble" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.trouble.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/trouble
  ];
}
