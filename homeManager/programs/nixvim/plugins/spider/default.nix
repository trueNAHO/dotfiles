{
  programs.nixvim.plugins.spider = {
    enable = true;

    keymaps = {
      motions = {
        w = "w";
        e = "e";
        b = "b";
        g = "ge";
      };

      silent = true;
    };

    skipInsignificantPunctuation = false;
  };
}
