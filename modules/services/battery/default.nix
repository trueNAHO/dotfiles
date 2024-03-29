{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../homeManager/services/dunst];

  options.modules.services.battery = {
    delta = lib.mkOption {
      default = 5;

      description = ''
        Minimum battery percentage drop since the last notification to trigger a
        new one.
      '';

      example = 10;
      type = lib.types.ints.between 0 100;
    };

    enable = lib.mkEnableOption "battery";

    runtimeDir = lib.mkOption {
      default = "$XDG_RUNTIME_DIR/battery";
      description = "Runtime directory for this service.";
      example = "$XDG_RUNTIME_DIR/battery.d";
      type = lib.types.str;
    };

    systemd.user.timers.battery.Timer.OnCalendar = lib.mkOption {
      default = "*:0/5";

      description = ''
        Set the [`systemd.user.timers.battery.Timer.OnCalendar`](
        https://nix-community.github.io/home-manager/options.html#opt-systemd.user.timers)
        setting.
      '';

      example = "*:0/1";
      type = lib.types.str;
    };

    urgency = let
      description = urgency: ''
        Battery percentages starting from this value trigger notifications
        with the `${urgency}` urgency level.
      '';
    in {
      critical = lib.mkOption {
        default = 25;
        description = description "critical";
        example = 10;
        type = lib.types.ints.between 1 100;
      };

      low = lib.mkOption {
        default = 75;
        description = description "low";
        example = 50;
        type = lib.types.ints.between 1 100;
      };

      normal = lib.mkOption {
        default = 50;
        description = description "normal";
        example = 25;
        type = lib.types.ints.between 1 100;
      };
    };
  };

  config = let
    cfg = config.modules.services.battery;
  in
    lib.mkIf cfg.enable {
      assertions = [
        {
          assertion =
            cfg.urgency.critical
            <= cfg.urgency.normal
            && cfg.urgency.normal
            <= cfg.urgency.low;

          message = let
            module = "modules.services.battery.urgency";
          in "Expected '${module}.critical <= ${module}.normal <= ${module}.low', got: '${toString cfg.urgency.critical} <= ${toString cfg.urgency.normal} <= ${toString cfg.urgency.low}'";
        }
      ];

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

                  text = let
                    maxBatteryValue = toString 100;
                    valueFile = "${cfg.runtimeDir}/value";
                  in ''
                    battery="$(acpi | awk '/Battery 0/ { print $0; exit }')"

                    battery_value_now="$(
                        awk -v FPAT='[[:digit:]]+' '{ print $2 }' <<< "$battery"
                    )"

                    mkdir --parent "${cfg.runtimeDir}"

                    if [[ -f "${valueFile}" ]]; then
                      battery_value_before="$(cat "${valueFile}")"
                    else
                      printf '%s\n' "${maxBatteryValue}" >"${valueFile}"
                      battery_value_before="${maxBatteryValue}"
                    fi

                    if (( battery_value_now > battery_value_before )); then
                      printf '%s\n' "$battery_value_now" >"${valueFile}"
                      exit 0

                    elif ((
                      battery_value_before -
                      battery_value_now <
                      ${toString cfg.delta}
                    )); then
                      exit 0

                    elif ((
                      battery_value_now <=
                      ${toString cfg.urgency.critical}
                    )); then
                      urgency="critical"

                    elif ((
                      battery_value_now <=
                      ${toString cfg.urgency.normal}
                    )); then
                      urgency="normal"

                    elif ((
                      battery_value_now <=
                      ${toString cfg.urgency.low}
                    )); then
                      urgency="low"

                    else
                      exit 0
                    fi

                    status="$(
                      awk -v FPAT='[a-zA-Z]+' '{print $2}' <<< "$battery"
                    )"

                    time_remaining="$(awk '{ print $5 }' <<< "$battery")"

                    notify-send \
                      --urgency "$urgency" \
                      "Battery" \
                      "<u>Capacity:</u> $battery_value_now%\n<u>Status:</u> $status\n<u>Time remaining:</u> $time_remaining\n<u>Urgency:</u> ''${urgency^}"

                    printf '%s\n' "$battery_value_now" >"${valueFile}"
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
              Unit = "${name}.service";
              OnCalendar = cfg.systemd.user.timers.battery.Timer.OnCalendar;
            };

            Unit.Description = "${description} scheduler";
          };
        };
      };
    };
}
