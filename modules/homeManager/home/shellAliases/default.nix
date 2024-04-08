{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.shellAliases.enable =
    lib.mkEnableOption "shellAliases";

  config = lib.mkIf config.modules.homeManager.home.shellAliases.enable {
    home.shellAliases = let
      clippy = "cargo clippy --all-targets --all-features -- -D warnings";
    in {
      c = "cd";
      cal = "${pkgs.util-linux.outPath}/bin/cal --monday";
      cg = "cargo";
      cl = clippy;
      clippy = clippy;
    };
  };
}
