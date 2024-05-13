{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.plugins.debugprint.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.debugprint";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.debugprint.enable {
    programs.nixvim.plugins.debugprint = {
      enable = true;

      settings.keymaps =
        builtins.mapAttrs
        (_: value: builtins.mapAttrs (_: value: "<leader>d${value}") value)
        {
          normal = {
            delete_debug_prints = "d";
            plain_above = "P";
            plain_below = "p";
            textobj_above = "O";
            textobj_below = "o";
            toggle_comment_debug_prints = "t";
            variable_above = "V";
            variable_below = "v";
          };

          visual = {
            variable_below = "v";
            variable_above = "V";
          };
        };
    };
  };
}
