{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [inputs.agenix.homeManagerModules.default];

  options.modules.agenix.homeManagerModules.default.enable =
    lib.mkEnableOption "agenix";

  config = lib.mkIf config.modules.agenix.homeManagerModules.default.enable {
    age.identityPaths = ["${config.home.homeDirectory}/.ssh/id_ed25519_age"];
  };
}
