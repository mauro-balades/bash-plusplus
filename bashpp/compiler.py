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

        while self.current_char != None and self.current_char in (self.LETTERS + self.NUMBERS + "_:"):
            id += self.current_char
            self.advance()

        return id

    def advance_until_char(self):

        try:
            while self.current_char in ' \t\r\n':
                self.output.add_output(self.current_char)
                self.advance()
        except TypeError: # Token is NoneType
            pass

    def generate_class(self, name, functions):
        pass

    def generate_function(self, func_name, args, block, output):

        output.add_output(f"{func_name}(")

        for i, arg in enumerate(args):

            output.add_output(arg)
            if not i == len(args) - 1:
                output.add_output(",")

        output.add_output(") {\n")
        output.add_output(block)
        output.add_output("\n}\n")


    def parse_required(self, char):
        self.advance_until_char()

        if not self.current_char == char:
            raise Exception(f"Expected \"{char}\" found \"{self.current_char or 'OTHER'}\"")

        self.advance()

    def parse_class(self):
        self.advance()
        self.parse_required("{")



        self.parse_required("}")
        self.advance()

    def parse_function(self):

        self.parse_required("(")

        args = []
        if not self.current_char == ")":
            args.append(self.get_identifier())

            while self.current_char == ",":
                self.advance()
                self.advance_until_char()
                args.append(self.get_identifier())

        else:
            self.advance()


        generated_fn = self.generate_function_stmt(Output())
        return args, str(generated_fn)

    def interpret_indentifier(self, identifier, output):
        if identifier == "class":
            self.advance()
            class_name = self.get_identifier()
            self.parse_class()
            print(class_name)
        elif identifier == "function":
            self.advance()
            func_name = self.get_identifier()
            args, block = self.parse_function()
            self.generate_function(func_name, args, block, output)
        else:
            output.add_output(identifier + " ")
            self.advance()

    def generate_function_stmt(self, output):

        self.advance()
        self.parse_required("{")

        while self.current_char != "}":

            if self.current_char is None: break

            if self.current_char in self.LETTERS:
                identifier = self.get_identifier()
                self.interpret_indentifier(identifier, output)
                self.advance()
            else:
                output.add_output(self.current_char)
                self.advance()

        self.advance()
        return output

    def generate(self):

        while self.current_char is not None:
            if self.current_char in ' \t\r\n':
                self.output.add_output(self.current_char)
                self.advance()
            elif self.current_char in self.LETTERS:
                identifier = self.get_identifier()
                self.interpret_indentifier(identifier, self.output)
                self.advance()
            else:
                self.output.add_output(self.current_char)
                self.advance()

        print(self.output)