{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../xdg];

  options.modules.homeManager.programs.imv.enable =
    lib.mkEnableOption "modules.homeManager.programs.imv";

  config =
    lib.mkIf
    config.modules.homeManager.programs.imv.enable
    (lib.mkMerge [
      {
        programs.imv = {
          settings.binds = {
            "<Shift+P>" = let
              printf = lib.getExe' pkgs.coreutils "printf";
            in ''${printf} '%s\n' "$imv_current_file"'';

            n = "next";
            p = "prev";
          };

          enable = true;
        };
      }

      (
        lib.mkIf
        (config.modules.homeManager.home.packages.gimp.enable or false)
        {
          modules.homeManager.xdg.mimeApps.enable = true;

          xdg.mimeApps.defaultApplications = let
            imvDesktop = "imv.desktop";
            imvDirDesktop = "imv-dir.desktop";
          in
            lib.mapAttrs' (name: lib.nameValuePair "image/${name}") {
              "bmp" = [imvDirDesktop imvDesktop];
              "gif" = [imvDirDesktop imvDesktop];
              "heif" = [imvDesktop];
              "jpeg" = [imvDirDesktop imvDesktop];
              "png" = [imvDirDesktop imvDesktop];
              "tiff" = [imvDirDesktop imvDesktop];
              "x-pcx" = [imvDirDesktop imvDesktop];
              "x-portable-anymap" = [imvDirDesktop imvDesktop];
              "x-portable-bitmap" = [imvDirDesktop imvDesktop];
              "x-portable-graymap" = [imvDirDesktop imvDesktop];
              "x-portable-pixmap" = [imvDirDesktop imvDesktop];
              "x-tga" = [imvDirDesktop imvDesktop];
              "x-xbitmap" = [imvDirDesktop imvDesktop];
            };
        }
      )
    ]);
}
