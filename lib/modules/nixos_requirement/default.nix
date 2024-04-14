/*
Generates a NixOS requirement activation script.

The `lib` argument is required to access the `lib.hm.dag.entryBefore` function.

# Type

```
nixos_requirement :: {
  documentation :: String;
  lib :: AttrSet;
  literalExpression :: String;
  src :: String;
} -> AttrSet
```

# Arguments

documentation
: Optionally specifies additional information or references.

lib
: The library attribute set.

literalExpression
: The literal Nix expression to include in the system configuration.

src
: The module requiring the system configuration.

# Example

```nix
documentation = "https://nixos.org/nixos/options.xhtml#opt-services.easyeffects.enable"
literalExpression = "programs.dconf.enable = true;"
src = "modules.homeManager.services.easyeffects"

nixos_requirement { inherit documentation lib literalExpression src; }
=> {
  after = [ ... ];
  before = [ ... ];
  data = "printf 'trace: INFO: modules.homeManager.services.easyeffects: %s\\n' \"include 'programs.dconf.enable = true;' in the system configuration: https://nixos.org/nixos/options.xhtml#opt-services.easyeffects.enable\"\n";
}

nixos_requirement { inherit lib literalExpression src; }
=> {
  after = [ ... ];
  before = [ ... ];
  data = "printf 'trace: INFO: modules.homeManager.services.easyeffects: %s\\n' \"include 'programs.dconf.enable = true;' in the system configuration\"\n";
}
```
*/
{
  documentation ? "",
  lib,
  literalExpression,
  src,
}:
import ../lib_hm_dag_entry_before_write_boundary_printf {
  inherit lib src;

  string =
    "include '${literalExpression}' in the system configuration"
    + (
      if documentation != ""
      then ": ${documentation}"
      else ""
    );
}
