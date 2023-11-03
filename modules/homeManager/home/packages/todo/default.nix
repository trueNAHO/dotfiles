{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.todo.enable =
    lib.mkEnableOption "todo";

  config = lib.mkIf config.modules.homeManager.home.packages.todo.enable {
    home.packages = [pkgs.todo];
  };
}
