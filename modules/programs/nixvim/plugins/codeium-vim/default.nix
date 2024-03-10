{
  config,
  lib,
  ...
}: {
  # TODO: Replace the activation script with an upstream VIM plugin option for
  # setting the config path storing the API key, similar to the 'config_path'
  # option in https://github.com/Exafunction/codeium.nvim:
  # https://github.com/Exafunction/codeium.vim/issues/303.
  home.activation.codeiumVim = let
    directory = "${config.xdg.dataHome}/.codeium";
  in
    lib.hm.dag.entryAfter ["writeBoundary"] ''
      mkdir --parents "${directory}"

      ln \
        --force \
        --symbolic \
        ${config.age.secrets.modulesProgramsNixvimPluginsCodeium.path} \
        "${directory}/config.json"
    '';

  programs.nixvim.plugins.codeium-vim.enable = true;
}
