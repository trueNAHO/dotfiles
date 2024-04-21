{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.xplr.enable =
    lib.mkEnableOption "modules.homeManager.programs.xplr";

  config = lib.mkIf config.modules.homeManager.programs.xplr.enable {
    home.packages = let
      # TODO: add missing dependencies upstream.
      dependencies.inputs.dragonXplr = with pkgs; [curl xdragon];
    in
      dependencies.inputs.dragonXplr;

    programs = {
      fish.functions.x = let
        xplr = lib.getExe config.programs.xplr.package;
      in {
        body = ''
          set --function pwd "$(${xplr} --print-pwd-as-result $argv)"

          if test -n $pwd
            cd -- $pwd
          end
        '';

        description = ''
          Open ${xplr} and change the working directory to the last visited one
        '';
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
