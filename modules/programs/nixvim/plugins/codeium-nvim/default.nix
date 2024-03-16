{config, ...}: {
  programs.nixvim.plugins.codeium-nvim = {
    configPath.__raw = ''
      vim.fn.expand(
        "${config.age.secrets.modulesProgramsNixvimPluginsCodeiumApiKey.path}"
      )
    '';

    enable = true;
  };
}
