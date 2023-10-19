{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.zathura.enable =
    lib.mkEnableOption "zathura";

  config = lib.mkIf config.modules.homeManager.programs.zathura.enable {
    programs.zathura = {
      enable = true;
      options.recolor = true;
    };
  };
}
