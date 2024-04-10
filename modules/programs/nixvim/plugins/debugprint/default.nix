{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.debugprint.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.debugprint";

  config = lib.mkIf config.modules.programs.nixvim.plugins.debugprint.enable {
    programs.nixvim = {
      keymaps = let
        leader = "<leader>d";
        requireDebugprintDebugprint = "require('debugprint').debugprint";
        requireDebugprintDeleteprints = "require('debugprint').deleteprints";
      in
        map (keymaps:
          {
            lua = true;

            options = {
              expr = true;
              silent = true;
            };
          }
          // keymaps)
        ((map (keymaps: {mode = "n";} // keymaps) [
            {
              action = "function() return ${requireDebugprintDebugprint}() end";
              key = "${leader}p";
            }

            {
              action = ''
                function()
                  return ${requireDebugprintDebugprint}({ above = true })
                end
              '';

              key = "${leader}P";
            }

            {
              action = ''
                function()
                  return ${requireDebugprintDebugprint}({ motion = true })
                end
              '';

              key = "${leader}m";
            }

            {
              action = ''
                function()
                  return ${requireDebugprintDebugprint}({
                    above = true,
                    motion = true,
                  })
                end
              '';

              key = "${leader}M";
            }

            {
              action = ''
                function()
                  return ${requireDebugprintDeleteprints}()
                end
              '';

              key = "${leader}d";
              options.expr = false;
            }
          ])
          ++ (map (keymaps: {mode = ["n" "v"];} // keymaps) [
            {
              action = ''
                function()
                  return ${requireDebugprintDebugprint}({ variable = true })
                end
              '';

              key = "${leader}v";
            }

            {
              action = ''
                function()
                  return ${requireDebugprintDebugprint}({
                    above = true,
                    variable = true,
                  })
                end
              '';

              key = "${leader}V";
            }
          ]));

      plugins.debugprint = {
        createKeymaps = false;
        enable = true;
      };
    };
  };
}
