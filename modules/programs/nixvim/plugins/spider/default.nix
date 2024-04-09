{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.spider.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.spider";

  config = lib.mkIf config.modules.programs.nixvim.plugins.spider.enable {
    programs.nixvim.plugins.spider = {
      enable = true;

      keymaps = {
        motions = {
          b = "b";
          e = "e";
          ge = "ge";
          w = "w";
        };

        silent = true;
      };

      skipInsignificantPunctuation = false;
    };
  };
}
