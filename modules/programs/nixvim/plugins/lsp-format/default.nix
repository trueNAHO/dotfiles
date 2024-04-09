{
  config,
  lib,
  ...
}: {
  imports = [../lsp];

  options.modules.programs.nixvim.plugins.lsp-format.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.lsp-format";

  config = lib.mkIf config.modules.programs.nixvim.plugins.lsp-format.enable {
    modules.programs.nixvim.plugins.lsp.enable = true;
    programs.nixvim.plugins.lsp-format.enable = true;
  };
}
