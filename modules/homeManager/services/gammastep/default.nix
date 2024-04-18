{
  config,
  lib,
  ...
}: {
  # https://github.com/nix-community/home-manager/blob/release-23.11/modules/services/redshift-gammastep/lib/options.nix#L54-L72
  options.modules.homeManager.services.gammastep = {
    enable = lib.mkEnableOption "modules.homeManager.services.gammastep";

    latitude = lib.mkOption {
      default = 48.0;

      description = ''
        Your current longitude, between `-180.0` and `180.0`. Must be provided
        along with longitude.
      '';
    };

    longitude = lib.mkOption {
      default = 16.0;

      description = ''
        Your current latitude, between `-90.0` and `90.0`. Must be provided
        along with latitude.
      '';
    };
  };

  config = let
    cfg = config.modules.homeManager.services.gammastep;
  in
    lib.mkIf cfg.enable {
      services.gammastep = {
        inherit (cfg) latitude longitude;
        enable = true;
      };
    };
}
