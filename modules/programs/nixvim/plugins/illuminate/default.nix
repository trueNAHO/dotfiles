{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.illuminate.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.illuminate";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.illuminate.enable {
    programs.nixvim.plugins.illuminate.enable = true;
  };
}
