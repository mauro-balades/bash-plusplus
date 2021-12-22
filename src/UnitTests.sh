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
# Copyright <Mauro Baladés> 2021
# Bash++ Is under the license of "GNU GENERAL PUBLIC LICENSE
# =========================================================================

import Classes


BASHPP_UnitColors_red= '\033[0;31m'
BASHPP_UnitColors_green= '\033[0;32m'
BASHPP_UnitColors_yellow= '\033[1;33m'
BASHPP_UnitColors_cyan= '\033[0;36m'

BASHPP_UnitColors_bold= '\033[1m'
BASHPP_UnitColors_reset= '\033[0m'

UnitTest=(
  function __new__
  # function __delete__

  function assert
  function assert_eq

  declare description
)

UnitTest::__new__() {
  local self=$1
  shift

  $self.description= "$1"
}

UnitTest::assert_eq() {
  local self=$1
  shift

  local expected="$1"
  local actual="$2"

  if [ "$expected" == "$actual" ]; then
    return 0
  else
    return 1
  fi
}

UnitTest::assert() {
  local self=$1
  shift

  IT="$1"
  VALUE1="$2"
  VALUE2="$3"

  if [[ $self.assert_eq VALUE1 VALUE2 ]];
  then
    # TODO finish message
    echo -e "${BASHPP_UnitColors_green}✔️${BASHPP_UnitColors_reset}"
  else
    # TODO print error
  fi
}
