{
  homeManagerConfig,
  imports,
  inputs,
  name,
  pkgs,
  system,
}: {
  ${name} = inputs.homeManager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {inherit inputs system;};

    modules = [
      ({config, ...}: {
        inherit imports;

        config = pkgs.lib.mkMerge [
          {
            home = {
              homeDirectory = "/home/${config.home.username}";
              stateVersion = "23.05";
              username = "naho";
            };
          }

          homeManagerConfig
        ];
      })
    ];
  };
}
