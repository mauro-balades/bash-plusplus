#!/bin/bash

# ================================ BASH ++ ================================
#
#    ...............................................
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@.(@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@      @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@      #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@       @@@@@@@@@@@@@@@@@@@@@@@@  @@@   @@
#    @@@@@@@@@@@@@      ,@@@@@@@@@@@@@@@@@@@@      @ @@@@@@
#    @@@@@@@@@@.      @@@@@@@@@@@@@@@@@@@@@@@@@  @@@   @@
#    @@@@@@@@      .@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@    @@@@@@@@             #@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
#    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&
#
# Copyright <Mauro Baladés> 2007
# Bash++ Is under the license of "GNU GENERAL PUBLIC LICENSE
# =========================================================================

# ImportService::AddModule (import.addm)
#
# Usage:
#   import.addm Classes
#
# Description:
#   import.addm basically adds a new module to the list.
#   This is used so that modules are not imported imported
#   than once.
#
# Arguments:
#   [string] module ($1): Module to add to _BASHPP_IMPORTED_FILES.
ImportService::AddModule() {
  # Get the length of the array
  len="${#_BASHPP_IMPORTED_FILES[@]}"

  # Add one to the length.
  # The length will now be the
  # new index in where the new
  # module will be appended
  (( len++ ))

  # Import the new module to the list
  _BASHPP_IMPORTED_FILES[index]="$1"
}

# ImportService::ImportModuleByPath
#
#
# Description:
#   This function should be private.
#   The function is used internally to source a new file and add it
#   to _BASHPP_IMPORTED_FILES by using ImportService::AddModule
#
# Arguments:
#   [string] module ($1): Module to add to _BASHPP_IMPORTED_FILES.
ImportService::ImportModuleByPath() {
  # Get the path
  local path="$1"
  shift

  # Initialize the return value
  RET=1

  # If the "file" has been sourced successfully:
  if builtin source "${path}" "$@" &> /dev/null;
  then
    # Add the module to _BASHPP_IMPORTED_FILES
    ImportService::AddModule "${path}"

    # Set the return to 0.
    # Why?
    #   If statements check if the function
    #   has returned 0 because "0" is the
    #   exit code for success.
    RET=0
  fi

  # Return if the file has successfully sourced
  return $RET
}

# ImportService::Exists (import.exists)
#
# Usage:
#   import.exists Classes
#
# Description:
#   import.exists checks if a module has already been loaded.
#
# Arguments:
#   [string] module ($1): Module to check if it exists.
ImportService::Exists() {
  local module="$1"

  # Check if module exists in array
  if [[ ${_BASHPP_IMPORTED_FILES[*]} =~ ${module} ]]; then
    return 1 # Exists
  else
    return 0 # It does not exists
  fi

}

# ImportService::NExists (import.nexists)
#
# Usage:
#   import.nexists Classes
#
# Description:
#   import.nexists gives a reversed boolean value from ImportService::Exists
#
# Arguments:
#   [string] module ($1): Module to check if it exists.
ImportService::NExists() {
  local module="$1"
  shift

  # Check if module exists in array
  if [[ ${_BASHPP_IMPORTED_FILES[*]} =~ ${module} ]];
  then
    return 0 # Exists
  else
    return 1 # It does not exists
  fi
}

# ImportService::GitHub (import.github)
#
# Usage:
#   import.github mauro-balades/bash-plusplus/blob/main/script.sh
#   import github:mauro-balades/bash-plusplus/blob/main/script.sh
#
# Description:
#   import.url fetches a github repo and the it sources it with it's
#   response contents. This can also be called by doing a normal import
#   with the prefix of ("github:").
#
# Note:
#   It fetches the file by the "raw.githubusercontent.com" domain.
#
# Arguments:
#   [any] path ($1): Path to fetch in "raw.githubusercontent.com".
ImportService::GitHub() {
  path="$1"
  url="https://raw.githubusercontent.com/$path" # Add github domain

  # Import like if it was a normal URL
  ImportService::ImportUrl "$url"
}

# ImportService::ImportUrl (import.url)
#
# Usage:
#   import.url https://my-domain.com/script.sh
#   import.url http://my-domain.com/script.sh # Supports http
#   import http://my-domain.com/script.sh # Supports http
#
# Description:
#   import.url fetches a site and the it sources it with it's
#   response contents. It supports https and http.
#
# Arguments:
#   [any] url ($1): URL to be fetched and sourced
ImportService::ImportUrl() {

  # Note: I consider directly running code retrieved
  # over the internet to be a serious security risk.
  # It's probably less risky if this is done over an
  # internal network (depending on its overall security).

  # Check if curl exists by calling it with the help section.
  # It is not recomended to have it with wdget.
  if ! curl -h &> /dev/null
  then
      # Without output for a document nor file.
      builtin source <(wget -O - -o /dev/null "${1}")
  else
    # We use the flag "-s" for silent mode
    builtin source <(curl -s "$1")
  fi

  # After sourcing the path, We add it to the
  # imported files
  ImportService::AddModule "$path"
}

# ImportService::SimpleImport (source | . | import.simple)
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
#   [any] script ($1): Bash script to be sourced
ImportService::SimpleImport() {
  local path="$1"

  if [[ 'github:' == $path* ]]; # Check if the path is for github
  then
    # Import a github path with ImportService::GitHub
    # In where raw.githubusercontent.com/ is being added
    # as a prefix in the path.
    ImportService::GitHub "${path:7}"
  elif [[ $path == 'https://'* ]] || [[ $path == 'http://'* ]]; # Check if it is an URL
  then
    # If the "path" is an URL, we just fetch it and
    # source it's response. We don't need to add
    # it to the imported files arrays here.
    #
    # Why?
    # Because we do exactly the same if it was a GitHub
    # path. If we do it this way, we can also check
    # if path has been imported twice from github
    # e.g. (Same URL)
    #   import https://raw.githubusercontent.com/...
    #   import github:...
    #
    # They would be the same URL, that is why we need to
    # do it this way.
    ImportService::ImportUrl "${path}"
  else

    # Check if module has been already sourced
    if ImportService::NExists "${path}";
    then
      # TODO: better error handling
      printf "\"$path\" has already been imported\n" >&2
      return 1 # DO NOT SOURCE AGAIN
    fi

    # We check for possible file solutions to be sourced.
    # This can create better Syntax reading.
    # e.g.
    #   import Classes
    #
    #   Possible cases:
    #     - Classes
    #     - ./Classes.sh
    #     - /usr/lib/bash++/Classes.sh
    #     - /usr/lib/bash++/Classes
    #     - $( pwd )/Classes
    #
    # As shown in the example, we can see how messy can
    # some of the URL's be, this is why this method implemented.
    # You can just compare and wich while you like.
    # If you like more the "messy" syntax, you can always do the full
    # path (NOT RECOMENDED).
    # e.g.
    #   import /usr/lib/bash++/Classes.sh
    if ImportService::ImportModuleByPath "${path}" "$@" || \
    ImportService::ImportModuleByPath "${libs}/${path}" "$@"|| \
    ImportService::ImportModuleByPath "${libs}/${path}.sh" "$@"|| \
    ImportService::ImportModuleByPath "${cpath}/${path}" "$@"|| \
    ImportService::ImportModuleByPath "./${path}.sh" "$@";
    then
      :
    else
      # TODO: better error handling
      printf "Unable to load $path\n" >&2
      exit 1
    fi
  fi
}

# ImportService::Import (import)
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
ImportService::Import() {

  # Iterate every argument
  for var in "$@"
  do
    # Source the script1
    ImportService::SimpleImport "${var}"
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
# NOTE: the libs path and BASHPP_LIBS will be generated with "sudo make install"
builtin declare -g libs="$BASHPP_LIBS"
builtin declare -g cpath="$( pwd )"

# Declare an array containing the imported files
# To avoid duplucation
builtin declare -ag _BASHPP_IMPORTED_FILES


# Import function API
alias import="ImportService::Import"

# Overrides
alias .="ImportService::SimpleImport"
alias source="ImportService::SimpleImport"

# Extending the API
alias import.url="ImportService::ImportUrl"
alias import.github="ImportService::ImportGitHub"
alias import.simple="ImportService::SimpleImport" # Same as source and .

# Utility functions
alias import.exists="ImportService::Exists"
alias import.nexists="ImportService::NExists"

alias import.addm="ImportService::AddModule"
