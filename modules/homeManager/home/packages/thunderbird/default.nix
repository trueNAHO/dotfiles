# TODO: Replace the manually added 'home.packages = [pkgs.thunderbird]' package
# with Home Manager's 'programs.thunderbird.enable' option, and remove all files
# generated by Thunderbird that have not been generated via Nix.
{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.thunderbird.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.thunderbird";

  config =
    lib.mkIf
    config.dotfiles.homeManager.home.packages.thunderbird.enable {
      home.packages = [pkgs.thunderbird];
    };
}
