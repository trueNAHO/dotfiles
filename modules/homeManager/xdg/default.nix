{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.xdg.enable = lib.mkEnableOption "xdg";

  config = lib.mkIf config.modules.homeManager.xdg.enable {
    xdg = {
      enable = true;

      userDirs = {
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
