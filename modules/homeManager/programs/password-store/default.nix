{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.password-store.enable =
    lib.mkEnableOption "modules.homeManager.programs.password-store";

  config = lib.mkIf config.modules.homeManager.programs.password-store.enable {
    programs.password-store = {
      enable = true;
      package = pkgs.pass-wayland.withExtensions (exts: [exts.pass-otp]);
    };
  };
}
