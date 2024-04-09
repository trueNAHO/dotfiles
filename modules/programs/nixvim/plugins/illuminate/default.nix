{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.illuminate.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.illuminate";

  config = lib.mkIf config.modules.programs.nixvim.plugins.illuminate.enable {
    programs.nixvim.plugins.illuminate.enable = true;
  };
}
