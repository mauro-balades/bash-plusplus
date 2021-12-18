
ImportService:ImportGitHub {

}

ImportService:ImportUrl {

}

ImportService:SimpleImport {
  path="$1"
  if [[ 'github:' == path* ]]; 
  then 
    ImportService:GitHub "${path:7}"
  else
    builtin source "$path" "$@" || printf "Unable to load $path" >&2 # TODO: better errors
  fi
}

ImportService:Import {

  for var in "$@"
  do
      if [[ 'github:' == var* ]]; 
      then 
        ImportService:GitHub "${var:7}"
      else
        ImportService:SimpleImport "${var}"
      fi
  done
}


shopt -s expand_aliases
alias import="ImportService:Import"
alias .="ImportService:SimpleImport"
alias source="ImportService:SimpleImport"
