{
  inputs,
  pkgs,
  ...
}:
inputs.homeManager.lib.homeManagerConfiguration {
  inherit pkgs;
  extraSpecialArgs = {inherit inputs;};

  modules = [
    {
      imports = [
        ../modules/homeManager/fonts
        ../modules/homeManager/home/packages/acpi
        ../modules/homeManager/home/packages/du-dust
        ../modules/homeManager/home/packages/dua
        ../modules/homeManager/home/packages/duf
        ../modules/homeManager/home/packages/entr
        ../modules/homeManager/home/packages/fd
        ../modules/homeManager/home/packages/glow
        ../modules/homeManager/home/packages/gping
        ../modules/homeManager/home/packages/grim
        ../modules/homeManager/home/packages/killall
        ../modules/homeManager/home/packages/pass
        ../modules/homeManager/home/packages/pipe-rename
        ../modules/homeManager/home/packages/procs
        ../modules/homeManager/home/packages/tldr
        ../modules/homeManager/home/packages/tokei
        ../modules/homeManager/home/packages/wl-clipboard
        ../modules/homeManager/home/shellAliases
        ../modules/homeManager/programs/bash
        ../modules/homeManager/programs/bat
        ../modules/homeManager/programs/btop
        ../modules/homeManager/programs/direnv
        ../modules/homeManager/programs/eza
        ../modules/homeManager/programs/feh
        ../modules/homeManager/programs/fish
        ../modules/homeManager/programs/fzf
        ../modules/homeManager/programs/gh
        ../modules/homeManager/programs/git
        ../modules/homeManager/programs/gpg
        ../modules/homeManager/programs/home-manager
        ../modules/homeManager/programs/jq
        ../modules/homeManager/programs/lazygit
        ../modules/homeManager/programs/mpv
        ../modules/homeManager/programs/qutebrowser
        ../modules/homeManager/programs/ripgrep
        ../modules/homeManager/programs/rofi
        ../modules/homeManager/programs/swaylock
        ../modules/homeManager/programs/wezterm
        ../modules/homeManager/programs/wlogout
        ../modules/homeManager/programs/xplr
        ../modules/homeManager/programs/zathura
        ../modules/homeManager/programs/zellij
        ../modules/homeManager/programs/zoxide
        ../modules/homeManager/services/dunst
        ../modules/homeManager/services/easyeffects
        ../modules/homeManager/services/gammastep
        ../modules/homeManager/services/gpg-agent
        ../modules/homeManager/services/swayidle
        ../modules/homeManager/wayland/windowManager/hyprland
        ../modules/programs/nixvim
        ../modules/services/battery
        ../modules/stylix

        {
          home = let
            username = "naho";
          in {
            homeDirectory = "/home/${username}";
            stateVersion = "23.05";
            username = username;
          };

          modules = {
            homeManager = {
              fonts.enable = true;

              home = {
                packages = {
                  acpi.enable = true;
                  du-dust.enable = true;
                  dua.enable = true;
                  duf.enable = true;
                  entr.enable = true;
                  fd.enable = true;
                  glow.enable = true;
                  gping.enable = true;
                  grim.enable = true;
                  killall.enable = true;
                  pass.enable = true;
                  pipe-rename.enable = true;
                  procs.enable = true;
                  tldr.enable = true;
                  tokei.enable = true;
                  wl-clipboard.enable = true;
                };

                shellAliases.enable = true;
              };

              programs = {
                bash.enable = true;
                bat.enable = true;
                btop.enable = true;
                direnv.enable = true;
                eza.enable = true;
                feh.enable = true;
                fish.enable = true;
                fzf.enable = true;
                gh.enable = true;
                git.enable = true;
                gpg.enable = true;
                home-manager.enable = true;
                jq.enable = true;
                lazygit.enable = true;
                mpv.enable = true;
                qutebrowser.enable = true;
                ripgrep.enable = true;

                rofi = {
                  enable = true;
                  pass.enable = true;
                };

                swaylock.enable = true;
                wezterm.enable = true;
                wlogout.enable = true;
                xplr.enable = true;
                zathura.enable = true;
                zellij.enable = true;
                zoxide.enable = true;
              };

              services = {
                dunst.enable = true;
                easyeffects.enable = true;
                gammastep.enable = true;
                gpg-agent.enable = true;
                swayidle.enable = true;
              };

              wayland.windowManager.hyprland.enable = true;
            };

            programs.nixvim.enable = true;
            services.battery.enable = true;
            stylix.enable = true;
          };

          nixpkgs.config.allowUnfree = true;
        }
      ];
    }
  ];
}
