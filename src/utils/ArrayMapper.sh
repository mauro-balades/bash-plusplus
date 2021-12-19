#!/bin/bash

_ArrayMapper=(
    proc __new__

    proc remove
    proc +=
    proc get
    proc size
)

_ArrayMapper::__new__()
{
    local self=$1
    shift

    eval ${self}__array=\(\)

    local count=0
    for i in "$@"; do
        eval ${self}__array[$count]=\$i

        (( ++count ))
    done
}

_ArrayMapper::get()
{
    local self=$1
    shift

    eval echo \"\${${self}__array[$1]}\"
}

_ArrayMapper::+=()
{
    local self=$1
    shift

    local new_index
    new_index=$($self.size)

    (( new_index < 0 )) && new_index=0

    for i in "$@"; do
        eval ${self}__array[$new_index]=\$i

        (( ++new_index ))
    done
}

_ArrayMapper::remove()
{
    local self=$1
    shift

    eval unset ${self}__array[$1]
    eval ${self}__array=\("\${${self}__array[@]}"\)
}

_ArrayMapper::size()
{
    local self=$1
    shift

    eval echo \${#${self}__array[@]}
}
