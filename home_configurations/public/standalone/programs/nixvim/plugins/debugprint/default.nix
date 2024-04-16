lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "debugprint" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.debugprint.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/debugprint
  ];
}
