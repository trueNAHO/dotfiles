{
  programs.nixvim.autoCmd = [
    {
      command = "%s/\\s\\+$//e";
      event = ["BufWritePre"];
      pattern = ["*"];
    }
  ];
}
