{
  programs.nixvim = {
    extraConfigLua = ''
      vim.opt.matchpairs:append("<:>")
      vim.opt.shortmess:append("I")
    '';

    options = {
      breakindent = true;
      colorcolumn = "+1";
      cursorline = true;
      expandtab = true;
      foldmethod = "marker";
      ignorecase = true;
      lazyredraw = true;
      linebreak = true;
      mouse = "a";
      relativenumber = true;
      scrolloff = 8;
      shiftwidth = 4;
      showbreak = "↪ ";
      smartcase = true;
      smartindent = true;
      softtabstop = 4;
      tabstop = 4;
      textwidth = 80;
      undofile = true;
    };
  };
}
