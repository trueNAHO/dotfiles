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
            in ''exec ${printf} '%s\n' "$imv_current_file"'';

            n = "next";
            p = "prev";
          };

          enable = true;
        };
      }

      (
        lib.mkIf (
          config
          ? modules.homeManager.home.packages.gimp.enable
          && config.modules.homeManager.home.packages.gimp.enable
        ) {
          modules.homeManager.xdg.mimeApps.enable = true;

          xdg.mimeApps.defaultApplications = let
            imvDesktop = "imv.desktop";
            imvDirDesktop = "imv-dir.desktop";
          in {
            "image/bmp" = [imvDirDesktop imvDesktop];
            "image/gif" = [imvDirDesktop imvDesktop];
            "image/heif" = [imvDesktop];
            "image/jpeg" = [imvDirDesktop imvDesktop];
            "image/png" = [imvDirDesktop imvDesktop];
            "image/tiff" = [imvDirDesktop imvDesktop];
            "image/x-pcx" = [imvDirDesktop imvDesktop];
            "image/x-portable-anymap" = [imvDirDesktop imvDesktop];
            "image/x-portable-bitmap" = [imvDirDesktop imvDesktop];
            "image/x-portable-graymap" = [imvDirDesktop imvDesktop];
            "image/x-portable-pixmap" = [imvDirDesktop imvDesktop];
            "image/x-tga" = [imvDirDesktop imvDesktop];
            "image/x-xbitmap" = [imvDirDesktop imvDesktop];
          };
        }
      )
    ]);
}
