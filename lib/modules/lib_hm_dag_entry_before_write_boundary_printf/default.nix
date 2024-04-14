/*
Generates an activation script for consistent logging.

# Type

```
lib_hm_dag_entry_before_write_boundary_printf :: {
  lib :: AttrSet;
  src :: String;
  string :: String;
} -> AttrSet
```

# Arguments

lib
: The library attribute set.

src
: The module initiating the activation script.

string
: The string to print.

# Examples

```nix
config.nixpkgs.config.allowUnfree = true

lib_hm_dag_entry_before_write_boundary_printf {
  inherit lib;

  src = "modules.homeManager.nixpkgs.config.allowUnfree";

  string = let
    allowUnfree = toString config.nixpkgs.config.allowUnfree;
  in "'nixpkgs.config.allowUnfree = ${allowUnfree};'";
}
=> {
  after = [ ... ];
  before = [ ... ];
  data = "printf 'trace: INFO: modules.homeManager.nixpkgs.config.allowUnfree: %s\\n' \"'nixpkgs.config.allowUnfree = 1;'\"\n";
}
*/
{
  lib,
  src,
  string,
}:
lib.hm.dag.entryBefore ["writeBoundary"] ''
  printf 'trace: INFO: ${src}: %s\n' "${string}"
''
