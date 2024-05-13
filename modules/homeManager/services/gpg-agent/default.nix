{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.services.gpg-agent.enable =
    lib.mkEnableOption "dotfiles.homeManager.services.gpg-agent";

  config = lib.mkIf config.dotfiles.homeManager.services.gpg-agent.enable {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      pinentryPackage = pkgs.pinentry-qt;
      sshKeys = ["77FC064D64233D538FB56C705932E759FFEF38B6"];
    };
  };
}
