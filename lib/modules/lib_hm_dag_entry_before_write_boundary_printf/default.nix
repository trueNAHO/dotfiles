{
  lib,
  src,
  string,
}:
lib.hm.dag.entryBefore ["writeBoundary"] ''
  printf 'trace: INFO: ${src}: %s\n' "${string}"
''
