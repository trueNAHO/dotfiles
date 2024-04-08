{
  inputs,
  pkgs,
  system,
}:
import ../../../../../lib/home_configurations/prependPrefix {
  inherit inputs pkgs system;

  files = [
    ./bash
    ./bashmount
    ./bat
    ./btop
    ./direnv
    ./eza
    ./feh
    ./firefox
    ./fish
    ./fzf
    ./git
    ./gpg
    ./home-manager
    ./imv
    ./jq
    ./kitty
    ./lazygit
    ./man
    ./mpv
    ./password-store
    ./qutebrowser
    ./ripgrep
    ./rofi
    ./swaylock
    ./taskwarrior
    ./wlogout
    ./xplr
    ./zathura
    ./zellij
    ./zoxide
  ];

  prefix = "programs";
}
