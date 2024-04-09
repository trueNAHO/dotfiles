{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.fidget.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.fidget";

  config = lib.mkIf config.modules.programs.nixvim.plugins.fidget.enable {
    programs.nixvim.plugins.fidget.enable = true;
  };
}
