{config, ...}: {
  programs.nixvim.plugins.codeium-nvim = {
    configPath.__raw = ''
      vim.fn.expand(
        "${config.age.secrets.modulesProgramsNixvimPluginsCodeium.path}"
      )
    '';

    enable = true;
  };
}
