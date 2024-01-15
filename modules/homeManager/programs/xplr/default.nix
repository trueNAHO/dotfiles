{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.xplr.enable = lib.mkEnableOption "xplr";

  config = lib.mkIf config.modules.homeManager.programs.xplr.enable {
    home.packages = let
      # TODO: add missing dependencies upstream.
      dependencies.inputs.dragonXplr = with pkgs; [curl xdragon];
    in
      dependencies.inputs.dragonXplr;

    programs = {
      fish.functions.x = {
        body = ''
          set -l pwd "$(${pkgs.xplr.pname} --print-pwd-as-result $argv)"

          if test -n $pwd
            cd -- $pwd
          end
        '';

        description = "Open ${pkgs.xplr.pname} and change the working directory to the last visited one";
      };

      xplr = {
        enable = true;

        extraConfig =
          builtins.concatStringsSep "\n"
          (map (plugin: "dofile('${plugin}/init.lua').setup()") [
            inputs.dragonXplr
            inputs.triPaneXplr
          ]);
      };
    };
  };
}
