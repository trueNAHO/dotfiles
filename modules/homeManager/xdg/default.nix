{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.xdg = {
    enable = lib.mkEnableOption "xdg";
    userDirs.enable = lib.mkEnableOption "xdg.userDirs";
  };

  config = let
    cfg = config.modules.homeManager.xdg;
  in {
    xdg = {
      enable = cfg.enable;

      userDirs = lib.mkIf cfg.userDirs.enable {
        desktop = config.home.sessionVariables.TMPDIR;
        documents = config.home.sessionVariables.TMPDIR;
        download = config.home.sessionVariables.TMPDIR;
        music = "${config.home.homeDirectory}/p/music";
        pictures = "${config.home.homeDirectory}/p/images";
        publicShare = config.home.sessionVariables.TMPDIR;
        templates = config.home.sessionVariables.TMPDIR;
        videos = "${config.home.homeDirectory}/p/videos";
      };
    };
  };
}
