{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../homeManager/services/dunst];
  options.modules.services.battery.enable = lib.mkEnableOption "battery";

  config = lib.mkIf config.modules.services.battery.enable {
    modules.homeManager.services.dunst.enable = true;

    systemd.user = let
      description = "Battery notifier";
      name = "battery";
    in {
      services = {
        ${name} = {
          Install.WantedBy = ["default.target"];

          Service = {
            ExecStart = let
              application = pkgs.writeShellApplication {
                inherit name;
                runtimeInputs = with pkgs; [acpi coreutils gawk libnotify];

                text = ''
                  get_notification_urgency() {
                    readonly MIN_DELTA="5"

                    delta="$(printf '%s\n' "$(( $1 - $2 ))")"

                    if (( delta < MIN_DELTA )); then
                      return 0
                    fi

                    if (( $2 <= 25 )); then
                      urgency="critical"
                    elif (( $2 <= 50 )); then
                      urgency="normal"
                    elif (( $2 <= 75 )); then
                      urgency="low"
                    else
                      return 0
                    fi

                    printf '%s\n' "$urgency"
                  }

                  main() {
                    FILE="/tmp/$(id --user)_systemd_service_battery"
                    readonly FILE

                    battery="$(acpi --battery | awk '/Battery 0/')"

                    battery_value_now="$(
                      printf '%s\n' "$battery" |
                        awk -v FPAT='[[:digit:]]+' '{ print $2 }'
                    )"

                    if [[ -f "$FILE" ]]; then
                      battery_value_before="$(cat "$FILE")"
                    else
                      battery_value_before="100"
                    fi

                    notification_urgency="$(
                      get_notification_urgency \
                        "$battery_value_before" \
                        "$battery_value_now"
                    )"

                    if [[ -n "$notification_urgency" ]]; then
                      notify-send \
                        --urgency "$notification_urgency" \
                        "Battery: $battery_value_now%"

                      printf '%s\n' "$battery_value_now" > "$FILE"
                    fi

                    return 0
                  }

                  main
                '';
              };
            in "${application}/bin/${application.meta.mainProgram}";

            Type = "oneshot";
          };

          Unit = {
            After = "graphical-session-pre.target";
            Description = description;
            PartOf = "graphical-session.target";
          };
        };
      };

      timers = {
        ${name} = {
          Install.WantedBy = ["timers.target"];

          Timer = {
            Unit = name;
            OnCalendar = "*:0/5";
          };

          Unit.Description = "${description} scheduler";
        };
      };
    };
  };
}
