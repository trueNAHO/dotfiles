{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.alacritty.enable =
    lib.mkEnableOption "alacritty";

  config = lib.mkIf config.modules.homeManager.programs.alacritty.enable {
    programs.alacritty.enable = true;
  };
}
