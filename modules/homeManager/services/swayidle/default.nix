{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../programs/swaylock];

  options.modules.homeManager.services.swayidle = {
    timeouts.command = {
      turnDisplaysOff = lib.mkOption {
        description = "Command to turn all displays off.";
        example = "swaymsg 'output * dpms off'";
        type = lib.types.str;
      };

      turnDisplaysOn = lib.mkOption {
        description = "Command to turn all displays on.";
        example = "swaymsg 'output * dpms on'";
        type = lib.types.str;
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
        command.lock = "${pkgs.swaylock}/bin/${pkgs.swaylock.pname} --daemonize";
      in {
        enable = true;

        events = [
          {
            event = "before-sleep";
            command = command.lock;
          }

          {
            event = "lock";
            command = command.lock;
          }
        ];

        systemdTarget = "graphical-session-pre.target";

        timeouts = let
          timeout = 5 * 60;
        in [
          {
            inherit timeout;
            command = command.lock;
          }

          {
            command = cfg.timeouts.command.turnDisplaysOff;
            resumeCommand = cfg.timeouts.command.turnDisplaysOn;
            timeout = builtins.floor (timeout * 1.2 + 0.5);
          }
        ];
      };
    };
}
