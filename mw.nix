{ coreutils, less, whois, writeShellScriptBin } :
writeShellScriptBin
  "mw"
  ''
  PATH=
  set -euo pipefail
  shopt -s shift_verbose

  SPACING=

  for d
  do
    ${coreutils}/bin/cat  << END
  ''${SPACING}### Handling domain '$d' ###

  ### START Whois data ###

  $(${coreutils}/bin/stdbuf --output=0 ${whois}/bin/whois --no-recursion -H "$d")

  ### END Whois data ###
  END

    SPACING=$'\n'
  done |& ${less}/bin/less -F -i
  ''
