{
  lib,
  src,
  string,
}:
lib.hm.dag.entryAfter ["writeBoundary"] ''printf '${src}: %s\n' "${string}"''
