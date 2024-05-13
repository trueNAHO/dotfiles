{
  config,
  lib,
  ...
}: {
  imports = [../treesitter];

  options.dotfiles.programs.nixvim.plugins.treesitter-context.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.treesitter-context";

  config =
    lib.mkIf
    config.dotfiles.programs.nixvim.plugins.treesitter-context.enable {
      dotfiles.programs.nixvim.plugins.treesitter.enable = true;
      programs.nixvim.plugins.treesitter-context.enable = true;
    };
}
