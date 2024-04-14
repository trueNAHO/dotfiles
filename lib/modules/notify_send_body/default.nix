/*
Generates the HTML body for notifications through the `notify-send` command.

# Type

```
notify_send_body :: {
  lib :: AttrSet;
  list :: [{
    name :: String;
    value :: String;
  }]
} -> String
```

# Arguments

lib
: The library attribute set.

list
: A list of `name`-`value` pairs, concatenated with newlines.

name
: The title of the `value`.

value
: The content of the `name`.

# Example

```nix
notify_send_body {
  inherit lib;

  list = [
    (
      lib.nameValuePair
      "Title 1"
      "Content 1"
    )

    (
      lib.nameValuePair
      "Title 2"
      "Content 2"
    )
  ];
}
=> "<u>Title 1:</u> Content 1\n<u>Title 2:</u> Content 2\n"
```
*/
{
  lib,
  list,
}:
lib.concatMapStrings
(
  {
    name,
    value,
  }: ''<u>${name}:</u> ${value}\n''
)
list
