{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.comment.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.comment";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.comment.enable {
    programs.nixvim.plugins.comment.enable = true;
  };
}
