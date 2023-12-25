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
            man = "$man/share/man";
            tmp = ".${man}";
          in ''
            mkdir --parent "$out" "${man}" "${tmp}"

            trap "rm --force --recursive ${tmp}" EXIT

            ${pkgs.fd.pname} \
              --extension adoc \
              -X \
              ${pkgs.asciidoctor-with-extensions.meta.mainProgram} \
              --backend manpage \
              --destination-dir "${tmp}"

            ${pkgs.fd.pname} --type file . "${tmp}" |
              while read -r file; do
                filename="$(basename --suffix .gz "$file")"
                output_directory="${man}/man''${filename##*.}"

                mkdir --parent "$output_directory"
                mv "$file" "$output_directory"
              done

          '';

          name = "dotfiles";
          nativeBuildInputs = with pkgs; [asciidoctor-with-extensions fd];
          outputs = ["out" "man"];
          src = ../../../..;
        })
    ];
  };
}
