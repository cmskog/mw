{
  less,
  lib,
  whois,
  writeShellScriptBin,

  # Arguments for callPackage
  mw-name ? "mw",
  my-domains ? []
}:

assert builtins.isString mw-name;
assert (builtins.stringLength mw-name) > 0;

assert builtins.isList my-domains;
assert builtins.all builtins.isString my-domains;

writeShellScriptBin
  mw-name
  ''
  PATH=
  set -euo pipefail
  shopt -s shift_verbose

  SPACING=

  if [[ $# -eq 0 ]]
  then
    set --${
             lib.strings.concatMapStrings
             (domain: " \"" + domain + "\"")
             my-domains
          }
  fi

  for d
  do
    echo "''${SPACING}### Handling domain '$d' ###

### START Whois data ###

$(${lib.meta.getExe whois} --no-recursion -H "$d")

### END Whois data ###"

    SPACING=$'\n'
  done |& ${less}/bin/less -F -i
  ''
