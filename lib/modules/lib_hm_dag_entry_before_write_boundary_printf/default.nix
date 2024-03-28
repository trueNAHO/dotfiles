{
  lib,
  src,
  string,
}:
lib.hm.dag.entryBefore ["writeBoundary"] ''printf '${src}: %s\n' "${string}"''
