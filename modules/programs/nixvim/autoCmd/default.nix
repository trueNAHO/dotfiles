{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.autoCmd.enable =
    lib.mkEnableOption "modules.programs.nixvim.autoCmd";

  config = lib.mkIf config.modules.programs.nixvim.autoCmd.enable {
    programs.nixvim.autoCmd = [
      {
        command = "%s/\\s\\+$//e";
        event = ["BufWritePre"];
        pattern = ["*"];
      }
    ];
  };
}
