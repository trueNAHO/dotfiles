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
  lib.info
  "${src}: include '${literalExpression}' in the system configuration${documentationString}"
