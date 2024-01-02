let
  publicKeys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICrrgYSUQdMPznQBTYSr4jf1p9feRpVWjFuW1MdmtQM4"
  ];
in {
  "modules/homeManager/programs/gh/gh_token.age".publicKeys = publicKeys;
  "modules/programs/nixvim/plugins/codeium.age".publicKeys = publicKeys;
}
