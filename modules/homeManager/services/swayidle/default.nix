{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../programs/swaylock];

  options.modules.homeManager.services.swayidle.enable =
    lib.mkEnableOption "swayidle";

  config = lib.mkIf config.modules.homeManager.services.swayidle.enable {
    modules.homeManager.programs.swaylock.enable = true;

    services.swayidle = let
      command = "${pkgs.swaylock}/bin/${pkgs.swaylock.pname} --daemonize";
    in {
      enable = true;

      events = [
        {
          event = "before-sleep";
          command = command;
        }

        {
          event = "lock";
          command = command;
        }
      ];

      systemdTarget = "graphical-session-pre.target";

      timeouts = [
        {
          timeout = 5 * 60;
          command = command;
        }
      ];
    };
  };
}
