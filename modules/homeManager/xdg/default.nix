{
  config,
  lib,
  ...
}: {
  imports = [../home/sessionVariables];

  options.dotfiles.homeManager.xdg = let
    module = "dotfiles.homeManager.xdg";
  in {
    enable = lib.mkEnableOption module;
    mimeApps.enable = lib.mkEnableOption "${module}.mimeApps";
    userDirs.enable = lib.mkEnableOption "${module}.userDirs";
  };

  config = let
    cfg = config.dotfiles.homeManager.xdg;
  in {
    dotfiles.homeManager.home.sessionVariables = {
      TMPDIR.enable = true;
      enable = true;
    };

    xdg = {
      enable = cfg.enable;
      mimeApps.enable = cfg.mimeApps.enable;

      userDirs = let
        personal = "${config.home.homeDirectory}/p";
      in
        lib.mkIf cfg.userDirs.enable {
          desktop = config.home.sessionVariables.TMPDIR;
          documents = config.home.sessionVariables.TMPDIR;
          download = config.home.sessionVariables.TMPDIR;
          music = "${personal}/music";
          pictures = "${personal}/images";
          publicShare = config.home.sessionVariables.TMPDIR;
          templates = config.home.sessionVariables.TMPDIR;
          videos = "${personal}/videos";
        };
    };
  };
}
