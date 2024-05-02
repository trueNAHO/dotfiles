lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "cmp" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.cmp.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/cmp
  ];
}
