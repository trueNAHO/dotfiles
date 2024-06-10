{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.packages.gpt4all.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.packages.gpt4all";

  config = lib.mkIf config.dotfiles.homeManager.home.packages.gpt4all.enable {
    home.packages = [pkgs.gpt4all];
  };
}
