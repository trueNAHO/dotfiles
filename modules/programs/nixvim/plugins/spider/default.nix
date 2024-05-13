{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.spider.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.spider";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.spider.enable {
    programs.nixvim.plugins.spider = {
      enable = true;

      keymaps = {
        motions = lib.genAttrs ["b" "e" "ge" "w"] (name: name);
        silent = true;
      };

      skipInsignificantPunctuation = false;
    };
  };
}
