{
  programs.nixvim.options = {
    breakindent = true;
    colorcolumn = "+1";
    cursorline = true;
    expandtab = true;
    foldmethod = "marker";
    ignorecase = true;
    matchpairs = "(:),{:},[:]" + ",<:>";
    mouse = "a";
    relativenumber = true;
    scrolloff = 8;
    shiftwidth = 4;
    shortmess = "filnxtToOF" + "I";
    smartcase = true;
    smartindent = true;
    softtabstop = 4;
    tabstop = 4;
    textwidth = 80;
    undofile = true;
  };
}
