{
  config,
  lib,
  ...
}: {
  imports = [../../../../homeManager/home/packages/rustup];

  options.modules.programs.nixvim.plugins.rustaceanvim.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.rustaceanvim";

  config = lib.mkIf config.modules.programs.nixvim.plugins.rustaceanvim.enable {
    modules.homeManager.home.packages.rustup.enable = true;
    programs.nixvim.plugins.rustaceanvim.enable = true;
  };
}
