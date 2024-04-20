{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../gpg];

  options.modules.homeManager.programs.git.enable =
    lib.mkEnableOption "modules.homeManager.programs.git";

  config = let
    git = lib.getExe config.programs.git.package;
  in
    lib.mkIf config.modules.homeManager.programs.git.enable {
      modules.homeManager.programs.gpg.enable = true;

      # The local 'home.shellAliases' variables are not replaced with the
      # arguably simpler
      #
      #     home.shellAliases.<ALIAS_2> = config.home.shellAliases.<ALIAS_1>;
      #
      # statement to prevent the following error:
      #
      #     error: infinite recursion encountered
      #
      # TODO: Patch an upstream fix.
      home.shellAliases = let
        cdgit = "cd -- \"$(${git} rev-parse --show-toplevel)\"";
      in {
        cdg = cdgit;
        cdgit = cdgit;
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
          c = "checkout";
          cm = "commit";
          cma = "!${git} add --all && ${git} commit";
          fix = ''!${git} add --all && ${git} commit --message "chore!: $(date "+%Y-%m-%d %H:%M:%S %z")"'';
          nuke = "!${git} reset --hard HEAD && ${git} clean -d --force";
          reword = "commit --amend";
          rh = "reset --hard";
          rm = "reset --mixed";
          rs = "reset --soft";
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
          rebase.updateRefs = true;
          rerere.enabled = true;
          submodule.recurse = true;
        };

        diff-so-fancy.enable = true;
        package = pkgs.gitAndTools.gitFull;

        signing = {
          key = "5FC6088AFB1A609D4532F9190C1C177B3B6468E0";
          signByDefault = true;
        };

        userEmail = "90870942+trueNAHO@users.noreply.github.com";
        userName = "NAHO";
      };
    };
}
