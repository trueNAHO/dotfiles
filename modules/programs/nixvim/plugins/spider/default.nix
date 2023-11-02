{
  programs.nixvim.plugins.spider = {
    enable = true;

    keymaps = {
      motions = {
        b = "b";
        e = "e";
        g = "ge";
        w = "w";
      };

      silent = true;
    };

    skipInsignificantPunctuation = false;
  };
}
