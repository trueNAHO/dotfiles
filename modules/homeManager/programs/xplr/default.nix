{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.xplr.enable = lib.mkEnableOption "xplr";

  config = lib.mkIf config.modules.homeManager.programs.xplr.enable {
    home = {
      # Add 'curl' and 'xdragon' packages because the 'inputs.dragonXplr' plugin
      # depends on them.
      packages = with pkgs; [curl xdragon];
    };

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
