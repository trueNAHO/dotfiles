{
  documentation ? "",
  lib,
  literalExpression,
  src,
}: let
  documentationString =
    if documentation != ""
    then " (${documentation})"
    else "";
in
  lib.hm.dag.entryAfter ["writeBoundary"] ''
    printf \
      '%s\n' \
      "${src}: include '${literalExpression}' in the system configuration${documentationString}"
  ''
