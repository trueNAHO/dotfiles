{
  inputs,
  pkgs,
  system,
}:
import ../../../../../../lib/home_configurations/prependPrefix {
  inherit inputs pkgs system;

  files = [
    ./acpi
    ./aria
    ./asciidoctor
    ./bandwhich
    ./catimg
    ./catnip
    ./diskonaut
    ./du-dust
    ./dua
    ./duf
    ./fd
    ./ffmpeg
    ./file
    ./gcc
    ./gimp
    ./glava
    ./glow
    ./gping
    ./inkscape
    ./kdenlive
    ./killall
    ./libreoffice
    ./neofetch
    ./p7zip
    ./parallel
    ./pipe-rename
    ./poppler_utils
    ./procs
    ./pstree
    ./ripgrep-all
    ./rustup
    ./thunderbird
    ./tldr
    ./tokei
    ./tree
    ./unzip
    ./wl-clipboard
    ./xdg-utils
    ./zip
  ];

  prefix = "packages";
}
