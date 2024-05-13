{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.surround.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.surround";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.surround.enable {
    programs.nixvim.plugins.surround.enable = true;
  };
}
