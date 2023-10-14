{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.wayland.windowManager.hyprland.enable =
    lib.mkEnableOption "hyprland";

  config =
    lib.mkIf
    config.modules.wayland.windowManager.hyprland.enable {
      home.sessionVariables.NIXOS_OZONE_WL = 1;

      wayland.windowManager.hyprland = {
        enable =
          lib.info
          "Add 'programs.hyprland.enable = true;' to the system configuration for Hyprland to work: https://nixos.wiki/wiki/Hyprland"
          true;

        settings = let
          gap = 5;
        in {
          animations.enabled = false;

          bind = let
            resize_1 = "20";
            resize_2 = "25";

            toggleMode = pkgs.writeShellApplication {
              name = "hyprland-toggle-mode";
              runtimeInputs = [pkgs.hyprland];

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
                  hyprctl getoption animations:enabled | awk 'NR == 2 { print $NF }'
                )"

                if (( animations_enabled == 0 )); then
                  hyprctl --batch '${batch}'
                else
                  hyprctl reload
                fi
              '';
            };
          in
            builtins.concatMap (
              index: let
                key = toString index;
                workspace = toString (index + 1);
              in [
                "SUPER SHIFT, ${key}, movetoworkspace, ${workspace}"
                "SUPER, ${key}, workspace, ${workspace}"
              ]
            ) (lib.lists.range 0 9)
            ++ [
              "SUPER CTRL, F, exec, ${toggleMode}/bin/${toggleMode.meta.mainProgram}"
              "SUPER CTRL, Q, exit,"
              "SUPER CTRL, S, exec, systemctl suspend"
              "SUPER SHIFT, F, fakefullscreen,"
              "SUPER SHIFT, J, swapnext, next"
              "SUPER SHIFT, K, swapnext, prev"
              "SUPER SHIFT, Q, killactive,"
              "SUPER, B, exec, ${config.home.sessionVariables.BROWSER}"
              "SUPER, F, fullscreen,"
              "SUPER, H, focusmonitor, -1"
              "SUPER, H, resizeactive, ${resize_1} ${resize_2}%"
              "SUPER, J, cyclenext, next"
              "SUPER, K, cyclenext, prev"
              "SUPER, L, focusmonitor, +1"
              "SUPER, L, resizeactive, -${resize_1} -${resize_2}%"
              "SUPER, T, exec, ${config.home.sessionVariables.TERMINAL}"
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
