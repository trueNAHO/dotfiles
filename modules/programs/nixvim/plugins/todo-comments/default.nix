{
  programs.nixvim = {
    keymaps = let
      requireTodocomments = "require('todo-comments')";
    in
      map (keymaps:
        {
          lua = true;
          mode = "n";
          options.silent = true;
        }
        // keymaps)
      [
        {
          action = "function() ${requireTodocomments}.jump_next() end";
          key = "]t";
        }

        {
          action = "function() ${requireTodocomments}.jump_prev() end";
          key = "[t";
        }
      ];

    plugins.todo-comments = {
      enable = true;

      extraOptions = {
        highlight = {
          comments_only = false;
          pattern = [''.*<(KEYWORDS)\s*:'' ''.*<(KEYWORDS)\s*!\(''];
        };

        keywords.TODO.alt = ["todo" "unimplemented"];
        search.pattern = ''\b(KEYWORDS)(:|!\()'';
      };

      keymaps = let
        leader = {
          telescope = "<leader>t";
          trouble = "<leader>l";
        };
      in {
        todoTelescope.key = "${leader.telescope}t";
        todoTrouble.key = "${leader.trouble}q";
      };
    };
  };
}
