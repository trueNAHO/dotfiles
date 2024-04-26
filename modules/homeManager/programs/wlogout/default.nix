{
  config,
  lib,
  ...
}: {
  imports = [../../services/swayidle];

  options.modules.homeManager.programs.wlogout.enable =
    lib.mkEnableOption "modules.homeManager.programs.wlogout";

  config = lib.mkIf config.modules.homeManager.programs.wlogout.enable {
    modules.homeManager.services.swayidle.enable = true;

    programs.wlogout = {
      enable = true;

      layout = [
        {
          action = "loginctl lock-session";
          keybind = "l";
          label = "lock";
          text = "Lock";
        }

        {
          action = "systemctl hibernate";
          keybind = "h";
          label = "hibernate";
          text = "Hibernate";
        }

        {
          action = "loginctl terminate-user ${config.home.username}";
          keybind = "q";
          label = "logout";
          text = "Logout";
        }

        {
          action = "systemctl poweroff";
          keybind = "p";
          label = "shutdown";
          text = "Shutdown";
        }

        {
          action = "systemctl suspend";
          keybind = "s";
          label = "suspend";
          text = "Suspend";
        }

        {
          action = "systemctl reboot";
          keybind = "r";
          label = "reboot";
          text = "Reboot";
        }
      ];
    };
  };
}
