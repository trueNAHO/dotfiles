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
            inherit (command) lock;
            event = "before-sleep";
          }

          {
            inherit (command) lock;
            event = "lock";
          }
        ];

        systemdTarget = "graphical-session-pre.target";

        timeouts = let
          timeout = 5 * 60;
        in [
          {
            inherit (command) lock;
            inherit timeout;
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
