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
        ../modules/fonts
        ../modules/home/packages/du-dust
        ../modules/home/packages/dua
        ../modules/home/packages/duf
        ../modules/home/packages/entr
        ../modules/home/packages/fd
        ../modules/home/packages/glow
        ../modules/home/packages/gping
        ../modules/home/packages/killall
        ../modules/home/packages/pass
        ../modules/home/packages/pipe-rename
        ../modules/home/packages/procs
        ../modules/home/packages/tldr
        ../modules/home/packages/tokei
        ../modules/home/packages/wl-clipboard
        ../modules/home/shellAliases
        ../modules/programs/bash
        ../modules/programs/bat
        ../modules/programs/btop
        ../modules/programs/direnv
        ../modules/programs/eza
        ../modules/programs/feh
        ../modules/programs/fish
        ../modules/programs/fzf
        ../modules/programs/gh
        ../modules/programs/git
        ../modules/programs/gpg
        ../modules/programs/lazygit
        ../modules/programs/mpv
        ../modules/programs/nixvim
        ../modules/programs/qutebrowser
        ../modules/programs/ripgrep
        ../modules/programs/wezterm
        ../modules/programs/xplr
        ../modules/programs/zathura
        ../modules/programs/zellij
        ../modules/programs/zoxide
        ../modules/services/easyeffects
        ../modules/services/gammastep
        ../modules/services/gpg-agent
        ../modules/stylix
        ../modules/wayland/windowManager/hyprland

        inputs.nixvim.homeManagerModules.nixvim
        inputs.stylix.homeManagerModules.stylix

        {
          home = let
            username = "naho";
          in {
            homeDirectory = "/home/${username}";
            stateVersion = "23.05";
            username = username;
          };

          modules = {
            fonts.enable = true;

            home = {
              packages = {
                du-dust.enable = true;
                dua.enable = true;
                duf.enable = true;
                entr.enable = true;
                fd.enable = true;
                glow.enable = true;
                gping.enable = true;
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
              lazygit.enable = true;
              mpv.enable = true;
              nixvim.enable = true;
              qutebrowser.enable = true;
              ripgrep.enable = true;
              wezterm.enable = true;
              xplr.enable = true;
              zathura.enable = true;
              zellij.enable = true;
              zoxide.enable = true;
            };

            services = {
              easyeffects.enable = true;
              gammastep.enable = true;
              gpg-agent.enable = true;
            };

            stylix.enable = true;
            wayland.windowManager.hyprland.enable = true;
          };

          nixpkgs.config.allowUnfree = true;
          programs.home-manager.enable = true;
        }
      ];
    }
  ];
}
