{
  config,
  inputs,
  lib,
  system,
  ...
}: {
  options.modules.nix-alien.enable = lib.mkEnableOption "nix-alien";

  config = lib.mkIf config.modules.nix-alien.enable {
    home.packages = [inputs.nix-alien.packages.${system}.nix-alien];
  };
}
