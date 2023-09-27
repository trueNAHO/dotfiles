{
  inputs,
  pkgs,
  ...
}: {
  home = {
    # Add 'curl' and 'xdragon' packages because the 'inputs.dragonXplr' plugin
    # depends on them.
    packages = with pkgs; [curl xdragon];

    shellAliases.x = "cd -- \"$(${pkgs.xplr.pname} --print-pwd-as-result)\" 2>/dev/null || true";
  };

  programs.xplr = {
    enable = true;

    extraConfig =
      builtins.concatStringsSep "\n"
      (map (plugin: "dofile('${plugin}/init.lua').setup()") [
        inputs.dragonXplr
        inputs.triPaneXplr
      ]);
  };
}
