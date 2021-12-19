#!/bin/bash
import Classes

Logger=(

  # Define colors
  proc bold         = Logger::bold
  proc underline    = Logger::underline
  proc reset        = Logger::reset

  proc purple       = Logger::purple
  proc red          = Logger::red
  proc green        = Logger::green
  proc tan          = Logger::tan
  proc blue         = Logger::blue

  proc reset        = Logger::reset
)

Logger::bold        () { return $(tput bold)      }
Logger::underline   () { return $(tput sgr 0 1)   }
Logger::reset       () { return $(tput sgr0)      }

Logger::purple      () { return $(tput setaf 171) }
Logger::red         () { return $(tput setaf 1)   }
Logger::green       () { return $(tput setaf 76)  }
Logger::tan         () { return $(tput setaf 3)   }
Logger::blue        () { return $(tput setaf 38)  }

Logger::reset       () { return "\033[m"          }
