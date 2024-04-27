{
  config,
  lib,
  pkgs,
  ...
}: let
  maximumBatteryCapacity = 100;
  module = "modules.services.battery";
in {
  imports = [../../homeManager/services/dunst];

  options.modules.services.battery = {
    delta = lib.mkOption {
      default = 5;

      description = let
        OnCalendar = "systemd.user.timers.battery.Timer.OnCalendar";
      in ''
        Minimum battery percentage drop since the last notification to trigger a
        new one. Set to `0` to receive notifications on every `${OnCalendar}`
        update.
      '';

      example = 10;
      type = lib.types.ints.between 0 maximumBatteryCapacity;
    };

    enable = lib.mkEnableOption module;

    runtimeDir = lib.mkOption {
      default = "$XDG_RUNTIME_DIR/battery";
      description = "Runtime directory for this service.";
      example = "$XDG_RUNTIME_DIR/battery.d";
      type = lib.types.str;
    };

    systemd.user.timers.battery.Timer.OnCalendar = lib.mkOption {
      default = "*:0/5";

      description = let
        url = "https://nix-community.github.io/home-manager/options.xhtml#opt-systemd.user.timers";
      in ''
        Set the [`systemd.user.timers.battery.Timer.OnCalendar`](${url})
        setting.
      '';

      example = "*:0/1";
    };

    urgency = let
      description = urgency: ''
        Battery percentages starting from this value trigger notifications
        with the `${urgency}` urgency level.
      '';

      type = lib.types.ints.between 1 maximumBatteryCapacity;
    in {
      critical = lib.mkOption {
        inherit type;

        default = 25;
        description = description "critical";
        example = 10;
      };

      low = lib.mkOption {
        inherit type;

        default = 75;
        description = description "low";
        example = 50;
      };

      normal = lib.mkOption {
        inherit type;

        default = 50;
        description = description "normal";
        example = 25;
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
            module.urgency = "${module}.urgency";
          in "Expected '${module.urgency}.critical <= ${module.urgency}.normal <= ${module.urgency}.low', got: '${toString cfg.urgency.critical} <= ${toString cfg.urgency.normal} <= ${toString cfg.urgency.low}'";
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
              ExecStart = lib.getExe (pkgs.writeShellApplication {
                inherit name;

                runtimeInputs = with pkgs; [acpi coreutils gawk libnotify];

                text = let
                  delta = toString cfg.delta;

                  maximumBatteryCapacityString =
                    toString maximumBatteryCapacity;

                  notifySendBody = lib.dotfiles.notifySend.body [
                    (lib.nameValuePair "Capacity" "$battery_value_now%")
                    (lib.nameValuePair "Status" "$status")
                    (lib.nameValuePair "Time remaining" "$time_remaining")
                    (lib.nameValuePair "Urgency" "\${urgency^}")
                  ];

                  urgency = {
                    critical = toString cfg.urgency.critical;
                    low = toString cfg.urgency.low;
                    normal = toString cfg.urgency.normal;
                  };

                  value = "${cfg.runtimeDir}/value";
                in ''
                  battery="$(acpi | awk '/Battery 0/ { print $0; exit }')"

                  battery_value_now="$(
                      awk -v FPAT='[[:digit:]]+' '{ print $2 }' <<< "$battery"
                  )"

                  mkdir --parent "${cfg.runtimeDir}"

                  if [[ -f "${value}" ]]; then
                    battery_value_before="$(cat "${value}")"
                  else
                    printf '%d\n' "${maximumBatteryCapacityString}" >"${value}"
                    battery_value_before="${maximumBatteryCapacityString}"
                  fi

                  if (( battery_value_now > battery_value_before )); then
                    printf '%d\n' "$battery_value_now" >"${value}"

                    printf \
                      "${value}: %d -> %d\n" \
                      "$battery_value_before" \
                      "$battery_value_now"

                    exit 0

                  elif ((
                    battery_value_before - battery_value_now < ${delta}
                  )); then
                    printf \
                      'Insignificant battery percentage drop: %d -> %d (delta: ${delta})\n' \
                      "$battery_value_before" \
                      "$battery_value_now" \

                    exit 0

                  elif (( battery_value_now <= ${urgency.critical})); then
                    urgency="critical"

                  elif (( battery_value_now <= ${urgency.normal})); then
                    urgency="normal"

                  elif (( battery_value_now <= ${urgency.low})); then
                    urgency="low"

                  else
                    printf \
                      "Battery percentage above 'low' urgency: %d > ${urgency.low}\n" \
                      "$battery_value_now"

                    exit 0
                  fi

                  status="$(
                    awk -v FPAT='[a-zA-Z]+' '{print $2}' <<< "$battery"
                  )"

                  time_remaining="$(awk '{ print $5 }' <<< "$battery")"

                  notify-send \
                    --urgency "$urgency" \
                    "Battery" \
                    "${notifySendBody}"

                  printf '%d\n' "$battery_value_now" >"${value}"
                '';
              });

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
              inherit (cfg.systemd.user.timers.battery.Timer) OnCalendar;
              Unit = "${name}.service";
            };

            Unit.Description = "${description} scheduler";
          };
        };
      };
    };
}
