{
  files,
  inputs,
  pkgs,
  prefix,
  system,
}: let
  propagate = file: import file {inherit inputs pkgs system;};
in
  pkgs.lib.mapAttrs'
  (name: value: pkgs.lib.nameValuePair "${prefix}-${name}" value)
  (builtins.foldl' (acc: file: acc // (propagate file)) {} files)
