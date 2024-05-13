{
  config,
  lib,
  ...
}: {
  imports = [../lsp];

  options.dotfiles.programs.nixvim.plugins.lsp-format.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.lsp-format";

  config = lib.mkIf config.dotfiles.programs.nixvim.plugins.lsp-format.enable {
    dotfiles.programs.nixvim.plugins.lsp.enable = true;
    programs.nixvim.plugins.lsp-format.enable = true;
  };
}
