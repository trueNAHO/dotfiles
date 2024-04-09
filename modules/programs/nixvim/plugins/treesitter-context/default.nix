{
  config,
  lib,
  ...
}: {
  imports = [../treesitter];

  options.modules.programs.nixvim.plugins.treesitter-context.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.treesitter-context";

  config =
    lib.mkIf
    config.modules.programs.nixvim.plugins.treesitter-context.enable {
      modules.programs.nixvim.plugins.treesitter.enable = true;
      programs.nixvim.plugins.treesitter-context.enable = true;
    };
}
