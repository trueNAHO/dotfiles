{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.sessionVariables = {
    BROWSER.enable = lib.mkEnableOption "sessionVariables.BROWSER";
    EDITOR.enable = lib.mkEnableOption "sessionVariables.EDITOR";
    MANPAGER.enable = lib.mkEnableOption "sessionVariables.MANPAGER";
    SHELL.enable = lib.mkEnableOption "sessionVariables.SHELL";
    TERMINAL.enable = lib.mkEnableOption "sessionVariables.TERMINAL";
    TMPDIR.enable = lib.mkEnableOption "sessionVariables.TMPDIR";
    enable = lib.mkEnableOption "sessionVariables";
  };

  config.home.sessionVariables = let
    cfg = config.modules.homeManager.home.sessionVariables;
    neovim = pkgs.neovim.meta.mainProgram;
  in
    lib.mkMerge [
      (lib.mkIf (cfg.enable || cfg.BROWSER.enable) {
        BROWSER = pkgs.qutebrowser.pname;
      })

      (lib.mkIf (cfg.enable || cfg.EDITOR.enable) {
        EDITOR = neovim;
      })

      (lib.mkIf (cfg.enable || cfg.MANPAGER.enable) {
        MANPAGER = "${neovim} +Man!";
      })

      (lib.mkIf (cfg.enable || cfg.SHELL.enable) {
        SHELL = pkgs.fish.pname;
      })

      (lib.mkIf (cfg.enable || cfg.TERMINAL.enable) {
        TERMINAL = pkgs.kitty.pname;
      })

      (lib.mkIf (cfg.enable || cfg.TMPDIR.enable) {
        TMPDIR = "${config.home.homeDirectory}/tmp";
      })
    ];
}
