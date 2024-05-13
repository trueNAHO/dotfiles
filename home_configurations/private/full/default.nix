lib:
lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration "full" {
  config.dotfiles = {
    agenix.homeManagerModules.default.enable = true;

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
          ffmpeg.enable = true;
          file.enable = true;
          gcc.enable = true;
          gimp.enable = true;
          glava.enable = true;
          glow.enable = true;
          gping.enable = true;
          inkscape.enable = true;
          kdenlive.enable = true;
          killall.enable = true;
          libreoffice.enable = true;
          neofetch.enable = true;
          p7zip.enable = true;
          parallel.enable = true;
          pipe-rename.enable = true;
          poppler_utils.enable = true;
          procs.enable = true;
          pstree.enable = true;
          ripgrep-all.enable = true;
          rustup.enable = true;
          thunderbird.enable = true;
          tldr.enable = true;
          tokei.enable = true;
          tree.enable = true;
          unzip.enable = true;
          wl-clipboard.enable = true;
          xdg-utils.enable = true;
          zip.enable = true;
        };

        sessionVariables = {
          enable = true;
          full = true;
        };

        shellAliases.enable = true;
      };

      nixpkgs.config.allowUnfree.enable = lib.mkDefault false;

      programs = {
        bash.enable = true;
        bashmount.enable = true;
        bat.enable = true;
        borgmatic.enable = true;
        btop.enable = true;
        direnv.enable = true;
        eza.enable = true;
        feh.enable = true;
        firefox.enable = true;
        fish.enable = true;
        fzf.enable = true;
        gh.enable = true;
        git.enable = true;
        gpg.enable = true;
        home-manager.enable = true;
        imv.enable = true;
        jq.enable = true;
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

    programs.nixvim = {
      enable = true;
      full = true;
    };

    services.battery.enable = true;
    stylix.enable = true;
    wayland.enable = true;
  };

  imports = [./imports.nix];
}
