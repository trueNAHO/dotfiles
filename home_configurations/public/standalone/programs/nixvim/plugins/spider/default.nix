lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "spider" {
  config.modules.programs.nixvim = {
    enable = true;
    plugins.spider.enable = true;
  };

  imports = [
    ../../../../../../../modules/programs/nixvim
    ../../../../../../../modules/programs/nixvim/plugins/spider
  ];
}
