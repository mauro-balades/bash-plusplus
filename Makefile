
PREFIX := /usr/lib/
NAME := bash++
LIBS := $(PREFIX)$(NAME)/libs
SOURCE := src

all: help

install: FORCE

	sudo mkdir -p $(PREFIX)$(NAME)
	sudo mkdir -p $(LIBS)
	sudo cp $(SOURCE)/Classes.sh $(LIBS)/Classes.sh
	sudo cp $(SOURCE)/Errors.sh $(LIBS)/Error.sh
	sudo cp $(SOURCE)/Import.sh $(LIBS)/Import.sh
	sudo cp $(SOURCE)/Logger.sh $(LIBS)/Logger.sh
	sudo cp $(SOURCE)/Types.sh $(LIBS)/Types.sh
	sudo cp $(SOURCE)/UnitTests.sh $(LIBS)/UnitTests.sh
	sudo cp $(SOURCE)/dotenv.sh $(LIBS)/dotenv.sh
	sudo cp -rf $(SOURCE)/utils $(LIBS)/utils

	if [ "$BASHPP_LIBS" = "" ]; then \
		export BASHPP_LIBS=$(LIBS); \
		sudo echo "BASHPP_LIBS=$(LIBS)" >> /etc/environment; \
	fi

uninstall: FORCE

	sudo rm -rf $(PREFIX)$(NAME)

help: FORCE

	@echo "Bash++ - help section"
	@echo ""
	@echo "About:"
	@echo "  Bash++ Is a bash framework to make bash an OO programming language."
	@echo "  It also brings new functionalities such as: Unit Testing, "
	@echo "  Logging, Importing, Types, Classes, Erorrs and many more to come"
	@echo ""
	@echo "Usage:"
	@echo "  make [...options] [command]"
	@echo ""
	@echo "Available commands:"
	@echo "  install   		- Install bash++"
	@echo "  uninstall 		- Uninstall bash++"
	@echo "  help     		- Show this message"
	@echo ""

.PHONY: FORCE
