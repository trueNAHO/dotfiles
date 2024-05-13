{
  config,
  lib,
  ...
}: {
  options.dotfiles.programs.nixvim.autoCmd.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.autoCmd";

  config = lib.mkIf config.dotfiles.programs.nixvim.autoCmd.enable {
    programs.nixvim.autoCmd = [
      {
        command = ''%s/\s\+$//e'';
        event = ["BufWritePre"];
        pattern = ["*"];
      }
    ];
  };
}
