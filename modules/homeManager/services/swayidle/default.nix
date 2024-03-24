{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../programs/swaylock];

  options.modules.homeManager.services.swayidle = {
    displayTimeout = {
      enable = lib.mkEnableOption "swayidle.displayTimeout";

      timeouts = {
        command = lib.mkOption {
          description = "Command to turn all displays off.";
          example = "swaymsg 'output * dpms off'";
          type = lib.types.str;
        };

        resumeCommand = lib.mkOption {
          description = "Command to turn all displays on.";
          example = "swaymsg 'output * dpms on'";
          type = lib.types.str;
        };

        timeout = lib.mkOption {
          default = 5 * 60;
          description = "Timeout in seconds.";
          type = lib.types.ints.positive;
        };
      };
    };

    enable = lib.mkEnableOption "swayidle";
  };

  config = let
    cfg = config.modules.homeManager.services.swayidle;
  in
    lib.mkIf cfg.enable {
      modules.homeManager.programs.swaylock.enable = true;

      services.swayidle = let
        command = "${pkgs.swaylock}/bin/${pkgs.swaylock.pname} --daemonize";
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
