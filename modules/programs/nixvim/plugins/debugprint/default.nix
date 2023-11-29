{
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
            action = "function() return ${requireDebugprintDebugprint}({above = true}) end";
            key = "${leader}P";
          }

          {
            action = "function() return ${requireDebugprintDebugprint}({motion = true}) end";
            key = "${leader}m";
          }

          {
            action = "function() return ${requireDebugprintDebugprint}({motion = true, above = true}) end";
            key = "${leader}M";
          }

          {
            action = "function() return ${requireDebugprintDeleteprints}() end";
            key = "${leader}d";
          }
        ])
        ++ (map (keymaps: {mode = ["n" "v"];} // keymaps) [
          {
            action = "function() return ${requireDebugprintDebugprint}({variable = true}) end";
            key = "${leader}v";
          }

          {
            action = "function() return ${requireDebugprintDebugprint}({above = true, variable = true}) end";
            key = "${leader}V";
          }
        ]));

    plugins.debugprint = {
      createCommands = false;
      createKeymaps = false;
      enable = true;
    };
  };
}
