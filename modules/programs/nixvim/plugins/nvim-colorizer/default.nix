{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.nvim-colorizer.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.nvim-colorizer";

  config =
    lib.mkIf
    config.modules.programs.nixvim.plugins.nvim-colorizer.enable {
      programs.nixvim.plugins.nvim-colorizer.enable = true;
    };
}
