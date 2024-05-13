{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../../agenix/homeManagerModules/default];

  options.dotfiles.homeManager.programs.borgmatic.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.borgmatic";

  config = lib.mkIf config.dotfiles.homeManager.programs.borgmatic.enable {
    dotfiles.agenix.homeManagerModules.default.enable = true;

    age.secrets.modulesHomeManagerProgramsBorgmaticEncryptionPasscommand = {
      file = ./encryption_passcommand.age;
    };

    programs.borgmatic = {
      backups.home = {
        consistency.checks = let
          monthly = "1 month";
          weekly = "1 week";
        in [
          {
            name = "archives";
            frequency = weekly;
          }

          {
            name = "data";
            frequency = monthly;
          }

          {
            name = "extract";
            frequency = monthly;
          }

          {
            name = "repository";
            frequency = weekly;
          }
        ];

        # https://torsion.org/borgmatic/docs/how-to/backup-to-a-removable-drive-or-an-intermittent-server
        hooks.extraConfig.before_backup = let
          repository = let
            label = "home";
          in
            (
              lib.lists.findFirst
              (repository: repository ? label && repository.label == label)
              (throw "undefined repository: ${label}")
              config.programs.borgmatic.backups.home.location.repositories
            )
            .path;
        in [''ls "${repository}" >/dev/null || exit 75''];

        location = {
          excludeHomeManagerSymlinks = true;

          repositories = [
            {
              label = "home";
              path = "/tmp/${config.home.username}/borgbackup";
            }
          ];

          sourceDirectories = [config.home.homeDirectory];
        };

        retention = {
          keepDaily = 7;
          keepHourly = 24;
          keepMinutely = 60;
          keepMonthly = 6;
          keepSecondly = 60;
          keepWeekly = 5;
          keepWithin = "2d";
          keepYearly = 1;
        };

        storage.encryptionPasscommand = let
          file = config.age.secrets.modulesHomeManagerProgramsBorgmaticEncryptionPasscommand.path;
        in "${pkgs.runtimeShell} -c '${lib.getExe' pkgs.coreutils "cat"} \"${file}\"'";
      };

      enable = true;
    };
  };
}
