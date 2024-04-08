{
  inputs,
  pkgs,
  system,
}:
import ../../../../../lib/home_configurations/prependPrefix {
  inherit inputs pkgs system;

  files = [./dunst ./easyeffects ./gammastep ./gpg-agent ./swayidle];
  prefix = "services";
}
