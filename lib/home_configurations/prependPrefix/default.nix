/*
Prepends a prefix to each attribute set key returned by a list of files.

# Type

```
prependPrefix :: {
  files :: [Path];
  inputs :: AttrSet;
  pkgs :: AttrSet;
  prefix :: String;
  system :: String;
} -> AttrSet
```

# Arguments

files
: The list of files returning attribute sets to prepend the prefix to.

inputs
: The attribute set of all the dependencies of the flake.

pkgs
: The Nixpkgs attribute set.

prefix
: The prefix to prepend to each attribute set key.

system
: The system architecture.

# Examples

```nix
system = "x86_64-linux"

import ./module { inherit inputs pkgs system; }
=> { module = { ... }; }

prependPrefix {
  inherit inputs pkgs system;

  files = [./module];
  prefix = "standalone";
}
=> { standalone-module = { ... }; }
*/
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
