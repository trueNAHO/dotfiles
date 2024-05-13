{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.programs.xplr.enable =
    lib.mkEnableOption "dotfiles.homeManager.programs.xplr";

  config = lib.mkIf config.dotfiles.homeManager.programs.xplr.enable {
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
          lib.concatMapStringsSep
          "\n"
          (module: "require('${module}').setup()")
          (builtins.attrNames config.programs.xplr.plugins);

        plugins = {
          dragon = inputs.dragonXplr;
          tri-pane = inputs.triPaneXplr;
        };
      };
    };
  };
}
