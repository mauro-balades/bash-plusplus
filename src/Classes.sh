#!/bin/bash

# Import necesary utility modules
import utils/ArrayMapper

# Declare associative arrays for bash++.
# User using the framework should never
# interact with this declarations.
declare -A __BASHPP_ADDR_TABLE
declare -A __BASHPP_OBEJCT_TABLE

VARIABLE_REG='_*\([a-zA-Z][a-zA-Z0-9_]*\)'
PREFIX_REGEX='\(_*\)[a-zA-Z][a-zA-Z0-9_]*'

ClassService::create_var_mapper() {
  local NAME="$1"       # Variable's name
  local VALUE_F="{$2-}" # Variable's value field

  eval "${NAME}_$2=${VALUE_F-}" # Create new variable

  local VAR=$(expr "${2-}" : $VARIABLE_REG || exit 0)
  local PREFIX=$(expr "${2-}" : $PREFIX_REGEX || exit 0)

  eval "$NAME.${PREFIX-}${VAR}() { echo \"\$${NAME}_$2\"; }"
  eval "$NAME.${PREFIX-}${VAR}=() { ${NAME}_$2=\$1; }"
}

ClassService::create_array_mapper()
{
    local NAME="$1"       # Variable's name
    local VALUE_F="${3-}" # Variable's value field

    # Create a new instance of _ArrayMapper
    # as a new variable called "mapper"
    new _ArrayMapper mapper ${VALUE_F-}

    local PREFIX=$(expr "${2-}" : PREFIX_REGEX || exit 0)
    local VAR=$(expr "${2-}" : VARIABLE_REG || exit 0)

    eval "$NAME.${PREFIX-}${VAR}() { echo \"${mapper}\"; }"
    eval "$NAME.${PREFIX-}${VAR}+=() { $mapper.+= \"\$@\"; }"
}

# ClassService:create_meta_object
#
# Description:
#   Create new object without registering it in the object table.
#
# Arguments:
#   [string] unique objectname
#   [string] class name
#   [string] variable name to export object name to
#   [any]    member declarations ...
ClassService::new_meta_object()
{
    # Declare local variables
    local NAME=$1

    # Shift is a builtin command in bash which after getting executed,
    # shifts/move the command line arguments to one position left.
    # This command is useful when you want to get rid of the command
    # line arguments which are not needed after parsing them.
    shift

    local CLASS=$1
    shift

    local VARNAME=$1
    shift

    local SHIFT # Integer used to sheft later
    local VALUE_FIELD
    local CLASS_FIELDS=1

    local PREFIX
    local VAR

    while ! [[ -z ${1-} ]]; do
        if [[ ${3-} = "=" ]]; then
            SHIFT=4
            VALUE_FIELD=${4-}
        else
            SHIFT=2
            VALUE_FIELD=  # empty
        fi

        # We check for keywords
        if [[ $1 = "declare" ]];
        then
            if [[ $2 = "arr" ]];
            then # Declaring a variable

                # Increment the shift
                ((SHIFT++))

                # Create an array mapp
                ClassService::create_array_mapper "${NAME}" "$3" "$VALUE_FIELD"
            else

                # Create a new variable
                ClassService::create_var_mapper "${NAME}" "$2" "$VALUE_FIELD"
            fi
        elif [[ $1 = "proc" ]];
        then # We found a function
            [[ -z $VALUE_FIELD ]] && VALUE_FIELD=${CLASS}::$2

             # Create a new function declaration
            eval "$NAME.$2() { $VALUE_FIELD $NAME \"\$@\"; }"
        else # The person is not capable to read the documentation
            echo -e "Bash++: Syntax error in class-field $CLASS_FIELDS in class $CLASS,
\texpected proc or declare keyword" >&2 # TODO: better errors
            return 1 # Return an error
        fi

        ((CLASS_FIELDS++))
        shift $SHIFT
    done

    eval "$VARNAME=$NAME"
    return 0 # Return no error
}

# ClassService:new_object (new)
#
# Description:
#   Create new object and register it in the object table.
#
# Usage:
#   new MyClass mc
#   mc.my_func
#
#   ======= OPTIONAL ARGS =======
#   new MyClass mc "hello!" "hello2" "hello3" ...
#
# Arguments:
#   [string] Variable name of the class array
#   [string] Variable name to export object name to
#   [string] (optional) arguments to constructor.
ClassService::new_object()
{
    # Declare local variables
    local CLASS=$1
    shift

    local VARNAME=$1
    shift

    local i

    # Increment class id number.
    if [[ -z ${__BASHPP_OBEJCT_TABLE[$CLASS]-} ]]; then
        __BASHPP_OBEJCT_TABLE[$CLASS]=1
    else
        ((__BASHPP_OBEJCT_TABLE[$CLASS] += 1))
    fi

    # Generate unique object-name.
    local OBJ_NAME="${CLASS}_Object_id_${__BASHPP_OBEJCT_TABLE[$CLASS]}"

    # Register object-name.
    __BASHPP_ADDR_TABLE[$CLASS]="${__BASHPP_ADDR_TABLE[$CLASS]-}:$OBJ_NAME:"


    # Create new object.
    eval ClassService::new_meta_object $OBJ_NAME $CLASS $VARNAME \"\${$CLASS[@]}\"

    # Call constructor.
    [[ $(type -t $OBJ_NAME.__new__) == proc ]] && $OBJ_NAME.__new__ "$@"
}

# ClassService::delete (del)
#
# Description:
#   Deletes All references to the object
#   and calls the destructor if it exists.
#
# Usage:
#   delete MyClass
#
# Arguments:
#   [any] A reference to an object.
ClassService::delete()
{
    local CLASSNAME=$(echo $1|sed -r 's/_Object_id_[0-9]+$//')

    __BASHPP_ADDR_TABLE[$CLASSNAME]=$(echo "${__BASHPP_ADDR_TABLE[$CLASSNAME]}"|sed -r "s/:$1://")

    if [[ -z ${__BASHPP_ADDR_TABLE[$CLASSNAME]} ]]; then
        unset __BASHPP_ADDR_TABLE[$CLASSNAME]
    fi

    # Check for destructor and call it if one is existent.
    [[ $(type -t $1.__delete__) == proc ]] && $1.__delete__
}

# ClassService::delete_all (del_all)
#
# Description:
#   Deletes all references to the objects of all or
#   specific classes.
#
# Usage:
#   delete_all
#   delete_all MyClass MyClass2
#
# Arguments:
#   [string] classname (optional): Classnames to delete ...
ClassService::delete_all()
{
    # Declare local variables
    local i
    local j

    if [[ -z ${1-} ]];
    then
        # Loop through all registered objects and delete them
        for i in "${__BASHPP_ADDR_TABLE[@]-}";
        do
            local a=$(echo "$i"| \
                # AWK is a programming language that is designed for processing
                # text-based data, either in files or data streams, or using shell
                # pipes.
                awk 'BEGIN { RS = ":+" } /^.+$/ {print $1" "}')

            for j in $a;
            do
                ClassService::delete $j
            done
        done
    else
        for i;
        do
            local str=${__BASHPP_ADDR_TABLE[$i]}
            local a=$(echo "$str"| \
                awk 'BEGIN { RS = ":+" } /^.+$/ {print $1" "}')

            for j in $a;
            do
                ClassService::delete $j
            done
        done
    fi
}

set -o pipefail

# The command "shopt -s expand_aliases" will allow alias expansion in non-interactive shells.
shopt -s expand_aliases

# Export the API
alias new="ClassService::new_object"
alias del="ClassService::delete"

# Expand extra API function exporting
alias new.meta="ClassService::new_meta_object"
alias del_all="ClassService::delete_all"

alias get_self="local self=$1 && shift"

# Make sure to delete all objects at end of program
# Trap allows you to catch signals and execute code when they occur.
trap 'ClassService::delete_all' TERM EXIT INT
