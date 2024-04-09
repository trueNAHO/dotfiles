{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.treesitter.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.treesitter";

  config = lib.mkIf config.modules.programs.nixvim.plugins.treesitter.enable {
    programs.nixvim.plugins.treesitter.enable = true;
  };
}
