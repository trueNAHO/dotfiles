{
  config,
  inputs,
  lib,
  ...
}: let
  module = "modules.agenix.homeManagerModules.default";
in {
  imports = [inputs.agenix.homeManagerModules.default];

  options.modules.agenix.homeManagerModules.default.enable =
    lib.mkEnableOption module;

  config = lib.mkIf config.modules.agenix.homeManagerModules.default.enable {
    age.identityPaths = ["${config.home.homeDirectory}/.ssh/age"];

    home.activation.${module} = let
      keys = builtins.concatStringsSep ", " config.age.identityPaths;
    in
      lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.printf
      module
      "at least one recipient key required: ${keys}";
  };
}
