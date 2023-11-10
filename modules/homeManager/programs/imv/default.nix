{
  config,
  lib,
  ...
}: {
  options.modules.homeManager.programs.imv.enable = lib.mkEnableOption "imv";

  config = lib.mkIf config.modules.homeManager.programs.imv.enable {
    programs.imv = {
      settings.binds = {
        "<Shift+P>" = ''exec printf '%s\n' "$imv_current_file"'';
        n = "next";
        p = "prev";
      };

      enable = true;
    };
  };
}
