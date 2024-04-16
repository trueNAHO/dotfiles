lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "rustaceanvim" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.rustaceanvim.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/rustaceanvim
  ];
}
