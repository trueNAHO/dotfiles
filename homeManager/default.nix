{config, ...}: {
  imports = [
    ./fonts
    ./home
    ./programs
    ./services
    ./stylix
    ./wayland
  ];

  home = {
    homeDirectory = "/home/${config.home.username}";
    stateVersion = "23.05";
    username = "naho";
  };

  nixpkgs.config.allowUnfree = true;
  programs.home-manager.enable = true;
}
