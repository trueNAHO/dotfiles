{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../../../wayland
    ../../../programs/rofi
    ../../../programs/wlogout
    ../../../services/dunst
    ../../../services/swayidle
  ];

  options.modules.homeManager.wayland.windowManager.hyprland.enable =
    lib.mkEnableOption "hyprland";

  config =
    lib.mkIf
    config.modules.homeManager.wayland.windowManager.hyprland.enable {
      modules = {
        homeManager = {
          programs = {
            rofi = {
              enable = true;
              pass.enable = true;
            };

            wlogout.enable = true;
          };

          services = {
            dunst.enable = true;

            swayidle.timeouts.command = let
              hyprctl = "${pkgs.hyprland}/bin/hyprctl";
            in {
              turnDisplaysOff = "${hyprctl} dispatch dpms off";
              turnDisplaysOn = "${hyprctl} dispatch dpms on";
            };
          };
        };

        wayland.enable = true;
      };

      wayland.windowManager.hyprland = {
        enable =
          lib.info
          "Add 'programs.hyprland.enable = true;' to the system configuration for '${pkgs.hyprland.meta.mainProgram}' to work: https://nixos.wiki/wiki/Hyprland"
          true;

        settings = let
          gap = 5;
        in {
          animations = let
            windowsBezier = "windowsBezier";
          in {
            animation = ["windows, 1, 7, ${windowsBezier}"];

            bezier = let
              curve =
                builtins.concatStringsSep
                ","
                (map toString [0.05 0.9 0.1 1.05]);
            in ["${windowsBezier}, ${curve}"];

            enabled = false;
          };

          bind = let
            applications = let
              decreaseString = "decrease";

              getBrightnessPercentage = pkgs.writeShellApplication {
                name = "get-brightness-percentage";
                runtimeInputs = with pkgs; [brightnessctl gawk];

                text = ''
                  brightnessctl --machine-readable |
                    awk -F ',' -v FPAT='[[:digit:]]+' '{print $3}'
                '';
              };

              getVolumePercentage = pkgs.writeShellApplication {
                name = "get-volume-percentage";
                runtimeInputs = with pkgs; [gawk wireplumber];

                text = ''
                  wpctl get-volume @DEFAULT_AUDIO_SINK@ |
                    awk '{ printf "%d\n", $NF * 100 }'
                '';
              };

              increaseString = "increase";
              maximiseString = "maximise";
              maximumBrightnessPercentage = 100;
              maximumVolumePercentage = 100;
              minimiseString = "minimise";
              minimumBrightnessPercentage = 1;
              minimumVolumePercentage = 0;

              setBrightnessMaximise = maximise: let
                type =
                  if maximise
                  then maximiseString
                  else minimiseString;

                value =
                  if maximise
                  then "${toString maximumBrightnessPercentage}%"
                  else "${toString minimumBrightnessPercentage}%";
              in
                pkgs.writeShellApplication {
                  name = "set-brightness-${type}";
                  runtimeInputs = [pkgs.brightnessctl];
                  text = ''brightnessctl set "${value}"'';
                };

              setBrightnessIncrease = let
                brightnessStepPercentage = 10;
              in
                increase: let
                  type =
                    if increase
                    then increaseString
                    else decreaseString;

                  value = let
                    percentage = "${toString brightnessStepPercentage}%";
                  in
                    if increase
                    then "+${percentage}"
                    else "${percentage}-";
                in
                  pkgs.writeShellApplication {
                    name = "set-brightness-${type}";
                    runtimeInputs = with pkgs;
                      [brightnessctl libnotify]
                      ++ [getBrightnessPercentage];

                    text = ''
                      # TODO:
                      # https://github.com/Hummer12007/brightnessctl/issues/82
                      brightnessctl \
                        --min-value="${toString minimumBrightnessPercentage}" \
                        set "${value}"

                      brightness="$(
                        ${getBrightnessPercentage.meta.mainProgram}
                      )"

                      if ((
                        brightness <= ${toString minimumBrightnessPercentage} ||
                        brightness >= ${toString maximumBrightnessPercentage}
                      )); then
                        notify-send "Brightness" "<u>Value:</u> $brightness%"
                      fi
                    '';
                  };

              setVolumeMaximise = maximise: let
                type =
                  if maximise
                  then maximiseString
                  else minimiseString;

                value =
                  if maximise
                  then "${toString maximumVolumePercentage}%"
                  else "${toString minimumVolumePercentage}%";
              in
                pkgs.writeShellApplication {
                  name = "set-volume-${type}";
                  runtimeInputs = [pkgs.wireplumber];

                  text = ''
                    wpctl set-volume @DEFAULT_AUDIO_SINK@ "${value}"
                  '';
                };

              setVolumeIncrease = let
                volumeStepPercentage = 5;
              in
                increase: let
                  type =
                    if increase
                    then increaseString
                    else decreaseString;

                  value = let
                    percentage = "${toString volumeStepPercentage}%";
                  in
                    if increase
                    then "${percentage}+"
                    else "${percentage}-";
                in
                  pkgs.writeShellApplication {
                    name = "set-volume-${type}";
                    runtimeInputs = with pkgs;
                      [libnotify wireplumber]
                      ++ [getVolumePercentage];

                    text = ''
                      wpctl set-volume @DEFAULT_AUDIO_SINK@ "${value}"

                      volume="$(${getVolumePercentage.meta.mainProgram})"

                      if ((
                        volume <= ${toString minimumVolumePercentage} ||
                        volume >= ${toString maximumVolumePercentage}
                      )); then
                        notify-send "Volume" "<u>Value:</u> $volume%"
                      fi
                    '';
                  };
            in {
              cycleLayout = pkgs.writeShellApplication {
                name = "${pkgs.hyprland.pname}-cycle-layout";
                runtimeInputs = with pkgs; [hyprland jq];

                text = let
                  general.layout = {
                    dwindle = "dwindle";
                    master = "master";
                  };
                in ''
                  old_layout="$(
                    hyprctl getoption -j general:layout | jq -r '.str'
                  )"

                  if [[ "$old_layout" == "${general.layout.dwindle}" ]]; then
                    new_layout="${general.layout.master}"
                  else
                    new_layout="${general.layout.dwindle}"
                  fi

                  hyprctl keyword general:layout "$new_layout"
                '';
              };

              decreaseBrightness = setBrightnessIncrease false;
              decreaseVolume = setVolumeIncrease false;

              hyprlandToggleMode = pkgs.writeShellApplication {
                name = "${pkgs.hyprland.pname}-toggle-mode";
                runtimeInputs = with pkgs; [hyprland jq];

                text = let
                  batch = builtins.concatStringsSep ";" (
                    map (keyword: "keyword ${keyword}") [
                      "animations:enabled 1"
                      "decoration:blur:enabled 1"
                      "decoration:drop_shadow 1"
                      "decoration:inactive_opacity 0.85"
                      "decoration:rounding ${toString fancy_gap}"
                      "general:border_size 1"
                      "general:gaps_in ${toString fancy_gap}"
                      "general:gaps_out ${toString (fancy_gap * 2)}"
                      "misc:animate_manual_resizes 1"
                      "misc:animate_mouse_windowdragging_resizes 1"
                    ]
                  );

                  fancy_gap = 20;
                in ''
                  animations_enabled="$(
                    hyprctl getoption -j animations:enabled | jq -r '.int'
                  )"

                  if (( animations_enabled == 0 )); then
                    hyprctl --batch '${batch}'
                  else
                    hyprctl reload
                  fi
                '';
              };

              increaseBrightness = setBrightnessIncrease true;
              increaseVolume = setVolumeIncrease true;

              maximiseBrightness = setBrightnessMaximise true;
              maximiseVolume = setVolumeMaximise true;
              minimiseBrightness = setBrightnessMaximise false;
              minimiseVolume = setVolumeMaximise false;

              recordEntireScreen = pkgs.writeShellApplication {
                name = "record-entire-screen";
                runtimeInputs = [pkgs.wf-recorder];

                text = ''
                  ${config.home.sessionVariables.TERMINAL} \
                    -e \
                    wf-recorder \
                    --audio \
                    -f "${config.home.sessionVariables.TMPDIR}/$(date "+%Y_%m_%d_%H_%M_%S").mp4"
                '';
              };

              recordSelection = pkgs.writeShellApplication {
                name = "record-selection";
                runtimeInputs = with pkgs; [wf-recorder slurp];

                text = ''
                  ${config.home.sessionVariables.TERMINAL} \
                    -e \
                    wf-recorder \
                    --audio \
                    --geometry "$(slurp)" \
                    -f "${config.home.sessionVariables.TMPDIR}/$(date "+%Y_%m_%d_%H_%M_%S").mp4"
                '';
              };

              screenshotActiveWindow = pkgs.writeShellApplication {
                name = "screenshot-active-window";
                runtimeInputs = with pkgs; [grim hyprland jq wl-clipboard];

                text = ''
                  hyprctl -j activewindow |
                    jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' |
                    grim -g - - |
                    wl-copy
                '';
              };

              screenshotSelection = pkgs.writeShellApplication {
                name = "screenshot-selection";
                runtimeInputs = with pkgs; [grim slurp wl-clipboard];
                text = "slurp | grim -g - - | wl-copy";
              };

              systemStatus = pkgs.writeShellApplication {
                name = "system-status";

                runtimeInputs = with pkgs;
                  [
                    acpi
                    brightnessctl
                    gawk
                    libnotify
                    wireplumber
                  ]
                  ++ [getBrightnessPercentage getVolumePercentage];

                text = ''
                  notify-send \
                    "System Status" \
                      "<u>Battery:</u> $(acpi | awk '{print substr($0, index($0,$3))}')\n<u>Brightness:</u> $(${getBrightnessPercentage.meta.mainProgram})%\n<u>Date:</u> $(date "+%Y-%m-%d %H:%M:%S")\n<u>Volume:</u> $(${getVolumePercentage.meta.mainProgram})%"
                '';
              };
            };

            resize = "10%";
          in
            builtins.concatMap (
              index: let
                key = toString index;
                workspace = toString (index + 1);
              in [
                "SUPER SHIFT, ${key}, movetoworkspacesilent, ${workspace}"
                "SUPER, ${key}, workspace, ${workspace}"
              ]
            ) (lib.lists.range 0 9)
            ++ [
              "SUPER ALT SHIFT, H, layoutmsg, orientationleft"
              "SUPER ALT SHIFT, J, layoutmsg, orientationbottom"
              "SUPER ALT SHIFT, K, layoutmsg, orientationtop"
              "SUPER ALT SHIFT, L, layoutmsg, orientationright"
              "SUPER ALT, C, centerwindow,"
              "SUPER ALT, D, exec, dunstctl close-all"
              "SUPER ALT, H, resizeactive, -${resize} 0"
              "SUPER ALT, J, resizeactive, 0 ${resize}"
              "SUPER ALT, K, resizeactive, 0 -${resize}"
              "SUPER ALT, L, resizeactive, ${resize} 0"
              "SUPER ALT, M, exec, ${applications.hyprlandToggleMode}/bin/${applications.hyprlandToggleMode.meta.mainProgram}"
              "SUPER ALT, N, exec, ${applications.cycleLayout}/bin/${applications.cycleLayout.meta.mainProgram}"
              "SUPER ALT, P, exec, ${applications.cycleLayout}/bin/${applications.cycleLayout.meta.mainProgram}"
              "SUPER CTRL SHIFT, H, exec, ${applications.minimiseVolume}/bin/${applications.minimiseVolume.meta.mainProgram}"
              "SUPER CTRL SHIFT, J, exec, ${applications.maximiseBrightness}/bin/${applications.maximiseBrightness.meta.mainProgram}"
              "SUPER CTRL SHIFT, K, exec, ${applications.minimiseBrightness}/bin/${applications.minimiseBrightness.meta.mainProgram}"
              "SUPER CTRL SHIFT, L, exec, ${applications.maximiseVolume}/bin/${applications.maximiseVolume.meta.mainProgram}"
              "SUPER CTRL, C, exec, loginctl lock-session"
              "SUPER CTRL, H, exec, ${applications.decreaseVolume}/bin/${applications.decreaseVolume.meta.mainProgram}"
              "SUPER CTRL, J, exec, ${applications.increaseBrightness}/bin/${applications.increaseBrightness.meta.mainProgram}"
              "SUPER CTRL, K, exec, ${applications.decreaseBrightness}/bin/${applications.decreaseBrightness.meta.mainProgram}"
              "SUPER CTRL, L, exec, ${applications.increaseVolume}/bin/${applications.increaseVolume.meta.mainProgram}"
              "SUPER CTRL, Q, exec, ${pkgs.wlogout.pname}"
              "SUPER CTRL, S, exec, systemctl suspend"
              "SUPER SHIFT, C, exec, ${applications.screenshotActiveWindow}/bin/${applications.screenshotActiveWindow.meta.mainProgram}"
              "SUPER SHIFT, F, fakefullscreen,"
              "SUPER SHIFT, J, swapnext, next"
              "SUPER SHIFT, K, swapnext, prev"
              "SUPER SHIFT, P, pin,"
              "SUPER SHIFT, Q, killactive,"
              "SUPER SHIFT, V, exec, ${applications.recordSelection}/bin/${applications.recordSelection.meta.mainProgram}"
              "SUPER, B, exec, ${config.home.sessionVariables.BROWSER}"
              "SUPER, C, exec, ${applications.screenshotSelection}/bin/${applications.screenshotSelection.meta.mainProgram}"
              "SUPER, F, fullscreen,"
              "SUPER, H, focusmonitor, -1"
              "SUPER, J, cyclenext, next"
              "SUPER, K, cyclenext, prev"
              "SUPER, L, focusmonitor, +1"
              "SUPER, P, exec, ${pkgs.rofi-pass.pname}"
              "SUPER, R, exec, rofi -show run"
              "SUPER, S, exec, ${applications.systemStatus}/bin/${applications.systemStatus.meta.mainProgram}"
              "SUPER, T, exec, ${config.home.sessionVariables.TERMINAL}"
              "SUPER, V, exec, ${applications.recordEntireScreen}/bin/${applications.recordEntireScreen.meta.mainProgram}"
              "SUPER, W, togglefloating,"
              "SUPER, mouse_down, workspace, e+1"
              "SUPER, mouse_up, workspace, e-1"
            ];

          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];

          general = {
            gaps_in = gap;
            gaps_out = gap;
          };

          gestures.workspace_swipe = true;

          decoration = {
            blur.enabled = false;
            dim_inactive = true;
            dim_strength = 0.15;
            drop_shadow = false;
            rounding = gap;
          };
        };
      };
    };
}
