lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "opts" {
  config.modules.programs.nixvim = {
    enable = true;
    opts.enable = true;
  };

  imports = [
    ../../../../../../modules/programs/nixvim
    ../../../../../../modules/programs/nixvim/opts
  ];
}
