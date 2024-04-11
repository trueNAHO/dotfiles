{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.home.shellAliases.enable =
    lib.mkEnableOption "modules.homeManager.home.shellAliases";

  config = lib.mkIf config.modules.homeManager.home.shellAliases.enable {
    home.shellAliases = {
      c = "cd";
      cal = "cal --monday";
    };
  };
}
