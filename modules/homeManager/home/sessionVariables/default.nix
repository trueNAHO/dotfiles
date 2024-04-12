{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.sessionVariables = {
    BROWSER.enable =
      lib.mkEnableOption "modules.homeManager.home.sessionVariables.BROWSER";

    EDITOR.enable =
      lib.mkEnableOption "modules.homeManager.home.sessionVariables.EDITOR";

    MANPAGER.enable =
      lib.mkEnableOption "modules.homeManager.home.sessionVariables.MANPAGER";

    SHELL.enable =
      lib.mkEnableOption "modules.homeManager.home.sessionVariables.SHELL";

    TERMINAL.enable =
      lib.mkEnableOption "modules.homeManager.home.sessionVariables.TERMINAL";

    TMPDIR.enable =
      lib.mkEnableOption "modules.homeManager.home.sessionVariables.TMPDIR";

    enable = lib.mkEnableOption "modules.homeManager.home.sessionVariables";
  };

  config.home.sessionVariables = let
    cfg = config.modules.homeManager.home.sessionVariables;
    neovim = pkgs.neovim.meta.mainProgram;
  in
    # The 'lib.mkMerge [(lib.mkIf <BOOL> {<VARIABLE> = <VALUE>;})];' pattern is
    # used instead of the simpler '{<VARIABLE> = lib.mkIf <BOOL> <VALUE>;};'
    # expression in order to avoid the following upstream error of the
    # 'home.sessionVariables.<VARIABLE>' option:
    #
    #     error: The option `home.sessionVariables.<VARIABLE>' is used but not
    #     defined.
    #
    # TODO: Patch an upstream fix.
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
