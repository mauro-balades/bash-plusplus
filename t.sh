#!/bin/bash

. "${BASHPP_LIBS}/Import.sh"

import Classes


Mc=(
   function __new__
)

Mc::__new__() {
   echo "hello"
}

new Mc mc
