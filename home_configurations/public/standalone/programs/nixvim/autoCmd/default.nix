lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "autoCmd" {
  config.modules.programs.nixvim = {
    autoCmd.enable = true;
    enable = true;
  };

  imports = [
    ../../../../../../modules/programs/nixvim
    ../../../../../../modules/programs/nixvim/autoCmd
  ];
}
