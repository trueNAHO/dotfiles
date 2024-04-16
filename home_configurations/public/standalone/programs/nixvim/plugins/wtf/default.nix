lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "wtf" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.wtf.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/wtf
  ];
}
