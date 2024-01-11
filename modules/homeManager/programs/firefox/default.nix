{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.firefox.enable =
    lib.mkEnableOption "firefox";

  config = lib.mkIf config.modules.homeManager.programs.firefox.enable {
    programs.firefox.enable = true;
  };
}
