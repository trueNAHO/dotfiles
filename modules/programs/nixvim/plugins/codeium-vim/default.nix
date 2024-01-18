{
  config,
  lib,
  ...
}: {
  # TODO: Replace the activation script with an upstream VIM plugin option for
  # setting the config path storing the API key, similar to the 'config_path'
  # option in https://github.com/Exafunction/codeium.nvim.
  home.activation.codeiumVim = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ln \
      --force \
      --symbolic \
      ${config.age.secrets.modulesProgramsNixvimPluginsCodeium.path} \
      "${config.xdg.dataHome}/.codeium/config.json"
  '';

  programs.nixvim.plugins.codeium-vim.enable = true;
}
