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
