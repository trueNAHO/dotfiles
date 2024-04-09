{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.trouble.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.trouble";

  config = lib.mkIf config.modules.programs.nixvim.plugins.trouble.enable {
    programs.nixvim = {
      keymaps = [
        {
          action = ''
            function() require("trouble").toggle("workspace_diagnostics") end
          '';

          key = "<leader>ll";
          lua = true;
          mode = "n";
          options.silent = true;
        }
      ];

      plugins.trouble.enable = true;
    };
  };
}
