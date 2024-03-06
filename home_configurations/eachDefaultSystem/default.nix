{
  inputs,
  pkgs,
  system,
}: {
  eachDefaultSystem = inputs.homeManager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {inherit inputs system;};

    modules = [
      ({config, ...}: {
        imports = [
          ../../modules/agenix/homeManagerModules/default
          ../../modules/home/packages/dotfiles
          ../../modules/homeManager/fonts
          ../../modules/homeManager/home/packages/acpi
          ../../modules/homeManager/home/packages/aria
          ../../modules/homeManager/home/packages/asciidoctor
          ../../modules/homeManager/home/packages/bandwhich
          ../../modules/homeManager/home/packages/catimg
          ../../modules/homeManager/home/packages/catnip
          ../../modules/homeManager/home/packages/diskonaut
          ../../modules/homeManager/home/packages/du_dust
          ../../modules/homeManager/home/packages/dua
          ../../modules/homeManager/home/packages/duf
          ../../modules/homeManager/home/packages/fd
          ../../modules/homeManager/home/packages/ferdium
          ../../modules/homeManager/home/packages/ffmpeg
          ../../modules/homeManager/home/packages/file
          ../../modules/homeManager/home/packages/gcc
          ../../modules/homeManager/home/packages/gimp
          ../../modules/homeManager/home/packages/glava
          ../../modules/homeManager/home/packages/glow
          ../../modules/homeManager/home/packages/gping
          ../../modules/homeManager/home/packages/kdenlive
          ../../modules/homeManager/home/packages/killall
          ../../modules/homeManager/home/packages/libreoffice
          ../../modules/homeManager/home/packages/neofetch
          ../../modules/homeManager/home/packages/parallel
          ../../modules/homeManager/home/packages/pipe_rename
          ../../modules/homeManager/home/packages/poppler_utils
          ../../modules/homeManager/home/packages/procs
          ../../modules/homeManager/home/packages/ripgrep-all
          ../../modules/homeManager/home/packages/rustup
          ../../modules/homeManager/home/packages/taskwarrior-tui
          ../../modules/homeManager/home/packages/thunderbird
          ../../modules/homeManager/home/packages/tldr
          ../../modules/homeManager/home/packages/tokei
          ../../modules/homeManager/home/packages/tree
          ../../modules/homeManager/home/packages/unzip
          ../../modules/homeManager/home/packages/wl_clipboard
          ../../modules/homeManager/home/packages/xdg_utils
          ../../modules/homeManager/home/packages/zip
          ../../modules/homeManager/home/shellAliases
          ../../modules/homeManager/nixpkgs/config/allowUnfree
          ../../modules/homeManager/programs/bash
          ../../modules/homeManager/programs/bashmount
          ../../modules/homeManager/programs/bat
          ../../modules/homeManager/programs/borgmatic
          ../../modules/homeManager/programs/btop
          ../../modules/homeManager/programs/direnv
          ../../modules/homeManager/programs/eza
          ../../modules/homeManager/programs/firefox
          ../../modules/homeManager/programs/fish
          ../../modules/homeManager/programs/fzf
          ../../modules/homeManager/programs/gh
          ../../modules/homeManager/programs/git
          ../../modules/homeManager/programs/gpg
          ../../modules/homeManager/programs/home_manager
          ../../modules/homeManager/programs/imv
          ../../modules/homeManager/programs/kitty
          ../../modules/homeManager/programs/lazygit
          ../../modules/homeManager/programs/man
          ../../modules/homeManager/programs/mpv
          ../../modules/homeManager/programs/password_store
          ../../modules/homeManager/programs/qutebrowser
          ../../modules/homeManager/programs/ripgrep
          ../../modules/homeManager/programs/rofi
          ../../modules/homeManager/programs/swaylock
          ../../modules/homeManager/programs/taskwarrior
          ../../modules/homeManager/programs/wlogout
          ../../modules/homeManager/programs/xplr
          ../../modules/homeManager/programs/zathura
          ../../modules/homeManager/programs/zellij
          ../../modules/homeManager/programs/zoxide
          ../../modules/homeManager/services/borgmatic
          ../../modules/homeManager/services/dunst
          ../../modules/homeManager/services/easyeffects
          ../../modules/homeManager/services/gammastep
          ../../modules/homeManager/services/gpg_agent
          ../../modules/homeManager/services/swayidle
          ../../modules/homeManager/systemd/user/tmpfiles/rules
          ../../modules/homeManager/wayland/windowManager/hyprland
          ../../modules/homeManager/xdg
          ../../modules/nix-alien
          ../../modules/programs/nixvim
          ../../modules/services/battery
          ../../modules/stylix
          ../../modules/wayland
        ];

        config = {
          modules = {
            agenix.homeManagerModules.default.enable = true;
            home.packages.dotfiles.enable = true;

            homeManager = {
              fonts.enable = true;

              home = {
                packages = {
                  acpi.enable = true;
                  aria.enable = true;
                  asciidoctor.enable = true;
                  bandwhich.enable = true;
                  catimg.enable = true;
                  catnip.enable = true;
                  diskonaut.enable = true;
                  du-dust.enable = true;
                  dua.enable = true;
                  duf.enable = true;
                  fd.enable = true;
                  ferdium.enable = true;
                  ffmpeg.enable = true;
                  file.enable = true;
                  gcc.enable = true;
                  gimp.enable = true;
                  glava.enable = true;
                  glow.enable = true;
                  gping.enable = true;
                  kdenlive.enable = true;
                  killall.enable = true;
                  libreoffice.enable = true;
                  neofetch.enable = true;
                  parallel.enable = true;
                  pipe-rename.enable = true;
                  poppler_utils.enable = true;
                  procs.enable = true;
                  ripgrep-all.enable = true;
                  rustup.enable = true;
                  taskwarrior-tui.enable = true;
                  thunderbird.enable = true;
                  tldr.enable = true;
                  tokei.enable = true;
                  tree.enable = true;
                  unzip.enable = true;
                  wl-clipboard.enable = true;
                  xdg-utils.enable = true;
                  zip.enable = true;
                };

                shellAliases.enable = true;
              };

              nixpkgs.config.allowUnfree.enable = pkgs.lib.mkDefault false;

              programs = {
                bash.enable = true;
                bashmount.enable = true;
                bat.enable = true;
                borgmatic.enable = true;
                btop.enable = true;
                direnv.enable = true;
                eza.enable = true;
                firefox.enable = true;
                fish.enable = true;
                fzf.enable = true;
                gh.enable = true;
                git.enable = true;
                gpg.enable = true;
                home-manager.enable = true;
                imv.enable = true;
                kitty.enable = true;
                lazygit.enable = true;
                man.enable = true;
                mpv.enable = true;
                password-store.enable = true;
                qutebrowser.enable = true;
                ripgrep.enable = true;

                rofi = {
                  enable = true;
                  pass.enable = true;
                };

                swaylock.enable = true;
                taskwarrior.enable = true;
                wlogout.enable = true;
                xplr.enable = true;
                zathura.enable = true;
                zellij.enable = true;
                zoxide.enable = true;
              };

              services = {
                borgmatic.enable = true;
                dunst.enable = true;
                easyeffects.enable = true;
                gammastep.enable = true;
                gpg-agent.enable = true;
                swayidle.enable = true;
              };

              systemd.user.tmpfiles.rules.enable = true;
              wayland.windowManager.hyprland.enable = true;

              xdg = {
                enable = true;
                mimeApps.enable = true;
                userDirs.enable = true;
              };
            };

            nix-alien.enable = true;
            programs.nixvim.enable = true;
            services.battery.enable = true;
            stylix.enable = true;
            wayland.enable = true;
          };

          home = {
            homeDirectory = "/home/${config.home.username}";
            stateVersion = "23.05";
            username = "naho";
          };
        };
      })
    ];
  };
}
