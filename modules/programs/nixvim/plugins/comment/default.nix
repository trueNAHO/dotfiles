{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.comment.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.comment";

  config = lib.mkIf config.modules.programs.nixvim.plugins.comment.enable {
    programs.nixvim.plugins.comment.enable = true;
  };
}
