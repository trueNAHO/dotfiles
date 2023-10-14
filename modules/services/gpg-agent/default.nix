{
  config,
  lib,
  ...
}: {
  options.modules.services.gpg-agent.enable = lib.mkEnableOption "gpg-agent";

  config = lib.mkIf config.modules.services.gpg-agent.enable {
    services.gpg-agent = {
      enable = true;
      enableSshSupport = true;
      sshKeys = ["77FC064D64233D538FB56C705932E759FFEF38B6"];
    };
  };
}
