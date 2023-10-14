{
  config,
  lib,
  ...
}: {
  options.modules.programs.zathura.enable = lib.mkEnableOption "zathura";

  config = lib.mkIf config.modules.programs.zathura.enable {
    programs.zathura.enable = true;
  };
}
