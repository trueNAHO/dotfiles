{
  config,
  lib,
  ...
}: {
  options.modules.programs.btop.enable = lib.mkEnableOption "btop";

  config = lib.mkIf config.modules.programs.btop.enable {
    programs.btop.enable = true;
  };
}
