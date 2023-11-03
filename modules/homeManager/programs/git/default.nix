{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.programs.git.enable = lib.mkEnableOption "git";

  config = let
    git = pkgs.git.pname;
  in
    lib.mkIf config.modules.homeManager.programs.git.enable {
      home.shellAliases = let
        cdgit = "cd -- \"$(${git} rev-parse --show-toplevel)\"";
      in {
        cdg = cdgit;
        cdgit = cdgit;
        cg = cdgit;
        g = git;
      };

      programs.git = let
        adg = "log --all --decorate --graph";
        append = "!${git} add --all && ${git} commit --amend --no-edit";
      in {
        aliases = {
          adg = adg;
          adgs = "${adg} --stat";
          adog = "${adg} --oneline";
          adogs = "${adg} --oneline --stat";
          app = append;
          append = append;
          br = "branch";
          cm = "commit";
          cma = "!${git} add --all && ${git} commit";
          co = "checkout";
          fix = "!${git} add --all && ${git} commit --message \"chore!: $(date)\"";
          mgd = "!${git} merge $1 && ${git} branch --delete $1 #";
          nuke = "!${git} reset --hard HEAD && ${git} clean -d --force";
          reword = "commit --amend";
          rs = "reset";
          rv = "revert";
          rw = "commit --amend";
          s = "status --short";
          sdiff = "!${git} diff && ${git} submodule foreach '${git} diff'";
          spush = "push --recurse-submodules=on-demand";
          supdate = "submodule update --remote --merge";
        };

        enable = true;

        extraConfig = {
          log.date = "iso";
          merge.conflictstyle = "diff3";
          rerere.enabled = true;
          submodule.recurse = true;
        };

        diff-so-fancy.enable = true;

        signing = {
          key = "5FC6088AFB1A609D4532F9190C1C177B3B6468E0";
          signByDefault = true;
        };

        userEmail = "90870942+trueNAHO@users.noreply.github.com";
        userName = "NAHO";
      };
    };
}
