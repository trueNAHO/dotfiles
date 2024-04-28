# This module is an interface preventing circular 'imports' dependencies.
{
  config,
  lib,
  pkgs,
  ...
}: {
  # To avoid circular 'imports' dependency edge cases, this module should not
  # declare any dependencies using 'imports'.
  imports = [];

  options.modules.homeManager.home.sessionVariables = let
    module = "modules.homeManager.home.sessionVariables";
  in {
    BROWSER.enable =
      lib.mkEnableOption "${module}.BROWSER";

    EDITOR.enable =
      lib.mkEnableOption "${module}.EDITOR";

    MANPAGER.enable =
      lib.mkEnableOption "${module}.MANPAGER";

    SHELL.enable =
      lib.mkEnableOption "${module}.SHELL";

    TERMINAL.enable =
      lib.mkEnableOption "${module}.TERMINAL";

    TMPDIR.enable =
      lib.mkEnableOption "${module}.TMPDIR";

    enable = lib.mkEnableOption module;
    full = lib.mkEnableOption "${module}.full";
  };

  # The native 'pkgs.<PACKAGE>' packages are used as a fallback when the
  # packages are unavailable in 'config' due to the intentional lack of
  # unconditional 'imports'.
  config.home.sessionVariables = let
    cfg = config.modules.homeManager.home.sessionVariables;
    neovim = lib.getExe (config.programs.nixvim.finalPackage or pkgs.neovim);
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
    lib.mkIf cfg.enable (lib.mkMerge [
      (lib.mkIf (cfg.full || cfg.BROWSER.enable) {
        BROWSER = lib.getExe (
          config.programs.qutebrowser.package or pkgs.qutebrowser
        );
      })

      (lib.mkIf (cfg.full || cfg.EDITOR.enable) {
        EDITOR = neovim;
      })

      (lib.mkIf (cfg.full || cfg.MANPAGER.enable) {
        MANPAGER = "${neovim} +Man!";
      })

      (lib.mkIf (cfg.full || cfg.SHELL.enable) {
        SHELL = lib.getExe (config.programs.fish.package or pkgs.fish);
      })

      (lib.mkIf (cfg.full || cfg.TERMINAL.enable) {
        TERMINAL = lib.getExe (config.programs.kitty.package or pkgs.kitty);
      })

      (lib.mkIf (cfg.full || cfg.TMPDIR.enable) {
        TMPDIR = "${config.home.homeDirectory}/tmp";
      })
    ]);
}
