{
  config,
  lib,
  ...
}: {
  imports = [../../../../homeManager/home/packages/rustup];

  options.dotfiles.programs.nixvim.plugins.rustaceanvim.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.rustaceanvim";

  config =
    lib.mkIf
    config.dotfiles.programs.nixvim.plugins.rustaceanvim.enable {
      dotfiles.homeManager.home.packages.rustup.enable = true;
      programs.nixvim.plugins.rustaceanvim.enable = true;
    };
}
