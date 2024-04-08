{
  config,
  lib,
  ...
}: {
  imports = [../home/sessionVariables];

  options.modules.homeManager.xdg = {
    enable = lib.mkEnableOption "modules.homeManager.xdg";
    mimeApps.enable = lib.mkEnableOption "modules.homeManager.xdg.mimeApps";
    userDirs.enable = lib.mkEnableOption "modules.homeManager.xdg.userDirs";
  };

  config = let
    cfg = config.modules.homeManager.xdg;
  in {
    modules.homeManager.home.sessionVariables.TMPDIR.enable = true;

    xdg = {
      enable = cfg.enable;
      mimeApps.enable = cfg.mimeApps.enable;

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
