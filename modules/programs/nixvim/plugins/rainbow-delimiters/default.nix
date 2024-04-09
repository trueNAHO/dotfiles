{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.rainbow-delimiters.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.rainbow-delimiters";

  config =
    lib.mkIf
    config.modules.programs.nixvim.plugins.rainbow-delimiters.enable {
      programs.nixvim.plugins = {
        rainbow-delimiters.enable = true;
        treesitter.enable = true;
      };
    };
}
