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

from bashpp.output import Output

import os
import string

class Compiler:

    default_debug = False

    content = ""

    LETTERS = string.ascii_letters
    NUMBERS = '1234567890'


    def __init__(self, *args, **kwargs):
        self.filename = kwargs.get("filename", None)
        self.debug = kwargs.get("filename", self.default_debug)

        self.output = Output()

        if self.filename is None:
            raise ValueError("Filename needs to be present in the arguments")

        self.check_file_exists()
        self.read_file()

        self.pos = -1
        self.current_char = None
        self.advance()

        self.generate()

    def check_file_exists(self):
        if not os.path.isfile(self.filename):
            raise IOError(f"File ({self.filename}) does not exists")

    def read_file(self):
        with open(self.filename) as f:
            self.content = f.read()

    def advance(self):
        self.pos += 1
        self.current_char = self.content[self.pos] if self.pos < len(self.content) else None

    def get_identifier(self):
        id = ''

        while self.current_char != None and self.current_char in (self.LETTERS + self.NUMBERS + "_::"):
            id += self.current_char
            self.advance()

        return id

    def interpret_indentifier(self, identifier):
        print(identifier)

    def generate(self):

        while self.current_char is not None:
            if self.current_char in ' \t' or self.current_char in '\r\n':
                self.output.add_output(self.current_char)
                self.advance()
            elif self.current_char in self.LETTERS:
                identifier = self.get_identifier()
                self.interpret_indentifier(identifier)