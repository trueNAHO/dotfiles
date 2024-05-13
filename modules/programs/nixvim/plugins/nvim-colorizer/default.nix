{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.nvim-colorizer.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.nvim-colorizer";

  config =
    lib.mkIf
    config.dotfiles.programs.nixvim.plugins.nvim-colorizer.enable {
      programs.nixvim.plugins.nvim-colorizer.enable = true;
    };
}
