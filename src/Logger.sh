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


import Classes

Logger=(

  function __new__ = Logger::__new__

  # Define colors
  # declare bold
  # declare underline
  #
  # declare purple
  # declare red
  # declare green
  # declare tan
  # declare blue
  #
  # declare reset
)

Logger::__new__() {
  local self=$1
  shift

}

# Logger::bold        () { return $(tput bold)      }
# Logger::underline   () { return $(tput sgr 0 1)   }
#
# Logger::purple      () { return $(tput setaf 171) }
# Logger::red         () { return $(tput setaf 1)   }
# Logger::green       () { return $(tput setaf 76)  }
# Logger::tan         () { return $(tput setaf 3)   }
# Logger::blue        () { return $(tput setaf 38)  }
#
# Logger::reset       () { return "\033[m"          }
