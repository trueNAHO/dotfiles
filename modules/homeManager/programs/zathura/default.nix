{
  config,
  lib,
  ...
}: {
  imports = [../../xdg];

  options.modules.homeManager.programs.zathura.enable =
    lib.mkEnableOption "modules.homeManager.programs.zathura";

  config =
    lib.mkIf
    config.modules.homeManager.programs.zathura.enable
    (lib.mkMerge [
      {
        programs.zathura = {
          enable = true;
          options.recolor = true;
        };
      }

      (
        lib.mkIf
        (config.modules.homeManager.home.packages.gimp.enable or false)
        {
          modules.homeManager.xdg.mimeApps.enable = true;

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
