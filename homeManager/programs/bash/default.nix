{pkgs, ...}: {
  programs = {
    bash = {
      enable = true;
      initExtra = "exec ${pkgs.fish.pname}";
    };

    fish.enable = true;
  };
}
