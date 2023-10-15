{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.ripgrep.enable =
    lib.mkEnableOption "ripgrep";

  config = lib.mkIf config.modules.homeManager.programs.ripgrep.enable {
    programs.ripgrep.enable = true;
  };
}
