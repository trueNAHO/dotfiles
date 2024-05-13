{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.programs.password-store.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.password-store";

  config = lib.mkIf config.dotfiles.homeManager.programs.password-store.enable {
    programs.password-store = {
      enable = true;
      package = pkgs.pass-wayland.withExtensions (exts: [exts.pass-otp]);
    };
  };
}
