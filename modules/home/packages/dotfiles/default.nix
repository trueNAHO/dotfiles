{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../../homeManager/programs/man];
  options.modules.home.packages.dotfiles.enable = lib.mkEnableOption "dotfiles";

  config = lib.mkIf config.modules.home.packages.dotfiles.enable {
    modules.homeManager.programs.man.enable = true;

    home.packages = [
      (pkgs.stdenv.mkDerivation
        {
          installPhase = let
            manDirectory = "share/man";
            tmpDirectory = ".this_directory_should_be_cleaned_up_at_the_end";
          in ''
            mkdir --parent "$out/${tmpDirectory}"

            trap "rm --force --recursive $out/${tmpDirectory}" EXIT

            ${pkgs.fd.pname} \
              --extension adoc \
              -X \
              ${pkgs.asciidoctor-with-extensions.meta.mainProgram} \
              --backend manpage \
              --destination-dir "$out/${tmpDirectory}"

            ${pkgs.fd.pname} --type file . "$out/${tmpDirectory}" |
              while read -r file; do
                filename="$(basename --suffix .gz "$file")"
                output_directory="$out/${manDirectory}/man''${filename##*.}"

                mkdir --parent "$output_directory"
                mv "$file" "$output_directory"
              done
          '';

          name = "dotfiles";
          nativeBuildInputs = with pkgs; [asciidoctor-with-extensions fd];
          src = ../../../..;
        })
    ];
  };
}
