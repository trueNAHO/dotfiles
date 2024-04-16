lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "options" {
  config.modules.programs.nixvim = {
    enable = true;
    options.enable = true;
  };

  imports = [
    ../../../../../../modules/programs/nixvim
    ../../../../../../modules/programs/nixvim/options
  ];
}
