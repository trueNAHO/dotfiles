{
  config,
  lib,
  ...
}: {
  options.modules.programs.nixvim.plugins.telescope.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.telescope";

  config = lib.mkIf config.modules.programs.nixvim.plugins.telescope.enable {
    programs.nixvim.plugins.telescope = {
      enable = true;
      settings.defaults.layout_strategy = "vertical";

      keymaps = let
        leader = {
          git = "<leader>g";
          telescope = "<leader>t";
        };
      in {
        "${leader.git}C" = "git_bcommits";
        "${leader.git}b" = "git_branches";
        "${leader.git}c" = "git_commits";
        "${leader.git}s" = "git_status";
        "${leader.telescope}C" = "command_history";
        "${leader.telescope}G" = "current_buffer_fuzzy_find";
        "${leader.telescope}b" = "buffers";
        "${leader.telescope}c" = "commands";
        "${leader.telescope}f" = "find_files";
        "${leader.telescope}g" = "live_grep";
        "${leader.telescope}h" = "help_tags";
        "${leader.telescope}m" = "man_pages";
        "${leader.telescope}o" = "oldfiles";
        "${leader.telescope}q" = "quickfix";
        "${leader.telescope}r" = "resume";
        "${leader.telescope}s" = "search_history";
      };
    };
  };
}
