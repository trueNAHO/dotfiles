lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "leap" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.leap.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/leap
  ];
}
