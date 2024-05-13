{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.treesitter.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.treesitter";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.treesitter.enable {
    programs.nixvim.plugins.treesitter.enable = true;
  };
}
