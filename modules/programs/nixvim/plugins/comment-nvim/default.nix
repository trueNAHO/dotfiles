{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.comment-nvim.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.comment-nvim";

  config = lib.mkIf config.modules.programs.nixvim.plugins.comment-nvim.enable {
    programs.nixvim.plugins.comment-nvim.enable = true;
  };
}
