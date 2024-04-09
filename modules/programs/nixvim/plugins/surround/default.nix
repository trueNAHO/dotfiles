{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.surround.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.surround";

  config = lib.mkIf config.modules.programs.nixvim.plugins.surround.enable {
    programs.nixvim.plugins.surround.enable = true;
  };
}
