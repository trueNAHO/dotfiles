{
  config,
  lib,
  ...
}: {
  imports = [../../xdg];

  options.dotfiles.homeManager.programs.zathura.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.zathura";

  config =
    lib.mkIf
    config.dotfiles.homeManager.programs.zathura.enable
    (lib.mkMerge [
      {
        programs.zathura = {
          enable = true;
          options.recolor = true;
        };
      }

      (
        lib.mkIf
        (config.dotfiles.homeManager.home.packages.gimp.enable or false)
        {
          dotfiles.homeManager.xdg.mimeApps.enable = true;

          xdg.mimeApps.defaultApplications =
            lib.mapAttrs'
            (name: lib.nameValuePair "application/${name}")
            {
              "pdf" = ["org.pwmt.zathura-pdf-mupdf.desktop"];
              "postscript" = ["org.pwmt.zathura-ps.desktop"];
            };
        }
      )
    ]);
}
