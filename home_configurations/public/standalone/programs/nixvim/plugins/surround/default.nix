lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "surround" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.surround.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/surround
  ];
}
