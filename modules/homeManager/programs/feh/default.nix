{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.feh.enable = lib.mkEnableOption "feh";

  config = lib.mkIf config.modules.homeManager.programs.feh.enable {
    programs.feh.enable = true;
    xdg.configFile."feh/themes".text = "${pkgs.feh.pname} --no-fehbg";
  };
}
