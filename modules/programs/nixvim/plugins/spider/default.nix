{
  programs.nixvim.plugins.spider = {
    enable = true;

    keymaps = {
      motions = {
        b = "b";
        e = "e";
        ge = "ge";
        w = "w";
      };

      silent = true;
    };

    skipInsignificantPunctuation = false;
  };
}
