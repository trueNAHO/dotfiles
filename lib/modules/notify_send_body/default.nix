{
  lib,
  list,
}:
lib.concatMapStrings
(
  {
    name,
    value,
  }: "<u>${name}:</u> ${value}\\n"
)
list
