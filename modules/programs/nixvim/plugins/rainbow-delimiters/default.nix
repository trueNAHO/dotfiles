{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.rainbow-delimiters.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.rainbow-delimiters";

  config =
    lib.mkIf
    config.dotfiles.programs.nixvim.plugins.rainbow-delimiters.enable {
      programs.nixvim.plugins = {
        rainbow-delimiters.enable = true;
        treesitter.enable = true;
      };
    };
}
