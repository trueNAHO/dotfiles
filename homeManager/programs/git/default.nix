{pkgs, ...}: let
  cdgit = "cd -- \"$(${pkgs.git.pname} rev-parse --show-toplevel)\"";
in {
  home.shellAliases = {
    cdg = cdgit;
    cdgit = cdgit;
    cg = cdgit;
    g = "git";
  };

  programs.git = {
    aliases = {
      adg = "log --all --decorate --graph";
      adgs = "log --all --decorate --graph --stat";
      adog = "log --all --decorate --oneline --graph";
      adogs = "log --all --decorate --oneline --graph --stat";
      append = "!git add --all && git commit --amend --no-edit";
      br = "branch";
      cm = "commit";
      cma = "!git add --all && git commit";
      co = "checkout";
      fixup = "!git add --all && git commit --message \"chore!: $(date)\"";
      nuke = "!git reset --hard HEAD && git clean -d --force";
      reword = "commit --amend";
      rs = "reset";
      rv = "revert";
      rw = "commit --amend";
      s = "status --short";
      sdiff = "!git diff && git submodule foreach 'git diff'";
      spush = "push --recurse-submodules=on-demand";
      supdate = "submodule update --remote --merge";
    };

    enable = true;

    extraConfig = {
      merge = {conflictstyle = "diff3";};
      rerere = {enabled = true;};
      submodule = {recurse = true;};
    };

    diff-so-fancy.enable = true;

    signing = {
      key = "5FC6088AFB1A609D4532F9190C1C177B3B6468E0";
      signByDefault = true;
    };

    userEmail = "90870942+trueNAHO@users.noreply.github.com";
    userName = "NAHO";
  };
}