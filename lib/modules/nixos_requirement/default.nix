{
  documentation ? "",
  lib,
  literalExpression,
  src,
}: let
  documentationString =
    if documentation != ""
    then ": ${documentation}"
    else "";
in
  import ../lib_hm_dag_entry_before_write_boundary_printf {
    inherit lib src;
    string = "include '${literalExpression}' in the system configuration${documentationString}";
  }
