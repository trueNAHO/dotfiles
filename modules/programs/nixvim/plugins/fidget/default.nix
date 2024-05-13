{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.fidget.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.fidget";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.fidget.enable {
    programs.nixvim.plugins.fidget.enable = true;
  };
}
