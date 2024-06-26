{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../programs/swaylock];

  options.dotfiles.homeManager.services.swayidle = {
    displayTimeout = {
      enable =
        lib.mkEnableOption
        "dotfiles.homeManager.services.swayidle.displayTimeout";

      timeouts = {
        command = lib.mkOption {
          default = "";
          description = "Command to turn all displays off.";
          example = "swaymsg 'output * dpms off'";
        };

        resumeCommand = lib.mkOption {
          default = "";
          description = "Command to turn all displays on.";
          example = "swaymsg 'output * dpms on'";
        };

        timeout = lib.mkOption {
          default = 5 * 60;
          description = "Timeout in seconds.";
          example = 10 * 60;
        };
      };
    };

    enable = lib.mkEnableOption "dotfiles.homeManager.services.swayidle";
  };

  config = let
    cfg = config.dotfiles.homeManager.services.swayidle;
  in
    lib.mkIf cfg.enable {
      dotfiles.homeManager.programs.swaylock.enable = true;

      services.swayidle = let
        command = "${lib.getExe pkgs.swaylock} --daemonize";
      in {
        enable = true;

        events = [
          {
            inherit command;
            event = "before-sleep";
          }

          {
            inherit command;
            event = "lock";
          }
        ];

        systemdTarget = "graphical-session-pre.target";

        timeouts = lib.mkIf cfg.displayTimeout.enable [
          {
            inherit command;
            inherit (cfg.displayTimeout.timeouts) timeout;
          }

          {
            inherit (cfg.displayTimeout.timeouts) command resumeCommand;

            timeout = builtins.floor (
              cfg.displayTimeout.timeouts.timeout * 1.2 + 0.5
            );
          }
        ];
      };
    };
}
