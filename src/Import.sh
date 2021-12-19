#!/bin/bash

ImportService:GitHub() {
  exit 0
}

ImportService:ImportUrl() {

  # Note: I consider directly running code retrieved
  # over the internet to be a serious security risk.
  # It's probably less risky if this is done over an
  # internal network (depending on its overall security).

  # We use the flag "-s" for silent mode
  # TODO: check if curl exists, if not do it with wget
  builtin source <(curl -s "$1")
}

# ImportServer:SimpleImport (source | . | import.simple)
#
# Usage:
#   source MyFile
#   source https://example.com/script.sh
#   source github:mauro-balades/bash-plusplus
#   source Logger # Builtin module
#
# Note:
#   It can also be used with "." e.g.
#     . MyFile
#
# Description:
#   SimpleImport is the function that makes sourcing happen.
#   The function overrides "source" and ".". This function
#   Can import github URLs and https/http URLs. It does not
#   support multiple files.
#
# Arguments:
#   [any] script: Bash script to be sourced
ImportService:SimpleImport() {
  path="$1"
  if [[ 'github:' == $path* ]];
  then
    ImportService:GitHub "${path:7}"
  elif [[ $path == 'https://'* ]] || [[ $path == 'http://'* ]];
  then
      ImportService:ImportUrl "${path}"
  else
    builtin source "${path}" "$@" &> /dev/null || \
    builtin source "${libs}" "$@" &> /dev/null || \
    builtin source "${libs}/${path}" "$@" &> /dev/null || \
    builtin source "${cpath}/${path}" "$@" &> /dev/null || \
    builtin source "./${path}.sh" "$@" &> /dev/null || printf "Unable to load $path" >&2
  fi
}

# ImportServer:Import (import)
#
# Usage:
#   import MyFile
#   import System # Builtin module
#   import github:mauro-balades/bash-plusplus
#   import https://example.com/script.sh
#   import script1 script2 ...
#
# Description:
#   This function is used to import your bash script.
#   The function is a replacement for "source" since
#   it contains more functionality and it makes the
#   code prettier
#
# Arguments:
#   [...any] scripts: Bash scripts to be imported
ImportService:Import() {

  # Iterate every argument
  for var in "$@"
  do
    # Source the script1
    ImportService:SimpleImport "${var}"
  done
}

# This particular option sets the exit code of a
# pipeline to that of the rightmost command to exit
# with a non-zero status, or to zero if all commands
# of the pipeline exit successfully.
set -o pipefail

# The command "shopt -s expand_aliases" will allow alias expansion in non-interactive shells.
shopt -s expand_aliases

# Declare bash++'s paths
# NOTE: the libs path will be generated with "sudo make install"
declare -g libs="/usr/bin/bash++/libs/"
declare -g cpath="$( pwd )"

# Import function API
alias import="ImportService:Import"

# Overrides
alias .="ImportService:SimpleImport"
alias source="ImportService:SimpleImport"

# Extending the API
alias import.url="ImportService:ImportUrl"
alias import.github="ImportService:ImportGitHub"
alias import.simple="ImportService:SimpleImport" # Same as source and .
