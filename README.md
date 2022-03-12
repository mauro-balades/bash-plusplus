<div id="top"></div>

<p align="center">
<img src="./logo.png" width="250" />
<h2 align="center">bash ++</h2>
  <p align="center">
    This is a framework to bring bash to a next level.
    <br />
    <a href="https://github.com/mauro-balades/bash-plusplus/tree/main/examples"><strong>Check out the examples »</strong></a>
    <br />
    <br />
    <a href="https://github.com/mauro-balades/bash-plusplus/projects/1">Project status</a>
    ·
    <a href="https://github.com/mauro-balades/bash-plusplus/issues">Report Bug</a>
    ·
    <a href="https://github.com/mauro-balades/bash-plusplus/pulls">Contribute code</a>
  </p>
</p>

# Index

- [What is bash++ ?](#what-is-bash----)
- [Installation](#installation)
- [Q/A](#QA)
  * [What's the point when python, perl and other more robust scripting languages exist?](#Whats-the-point-when-python-perl-and-other-more-robust-scripting-languages-exist)
- [Usage](#usage)
  * [Getting started](#getting-started)
  * [Bootstrap the project](#bootstrap-the-project)
  * [Functionalities](#functionalities)
    + [Import](#import)
      - [Import's extended API](#import-s-extended-api)
    + [Classes](#classes)
      - [Initiate a class](#initiate-a-class)
      - [Call class' attributes](#call-class--attributes)
    + [DotEnv](#-env)
- [License](#license)

# What is bash++ ?

Bash++ is a new way to bring bash to a next level. This framework introduces new functionalities to bash. Some of this functionalities are:

- [ ] Unit testing
- [x] Classes
- [x] Imports
- [x] DotEnv
- [ ] Logging
- [ ] Types
- [ ] Errors

* **_and many more!_**

Bash++ is designed so that people could build more complex apps creating better products. Note that this project is for people with experience with bash (not much, just simple understandings and how things usually work).

When you run `bash++` with bash, the application breaks. This is why you need to add `#!/usr/bash` to the start of the script ([see instructions here](#getting-started)).

Bash haves it's own module system, so you will have a bash++ folder in your `/usr/libs` directory (just so that you know).
<p align="right">(<a href="#top">back to top</a>)</p>

# Installation

To use `bash++` you will (obviously) need to install it. To install it, clone the repo by running the following command:

```
git clone https://github.com/mauro-balades/bash-plusplus
```

After cloning the repository, `cd` into that directory. Once you are in the directory called `bash++`. Run the following command to proceed with the installation.

*Note that you need to run it as root.*

```
sudo make install
```

When you have installed it, you will see a new directory (usually in `/usr/lib/bash++`). This directory is where all of bash's built-in libraries will be stored.

* See how to [install it localy for everyone to use](https://youtu.be/SSPK9Ftiw-w)

# Q/A

## What's the point when python, perl and other more robust scripting languages exist?

This is something that comes up really often, I've found that [Oil
Shell](http://www.oilshell.org/) main FAQ covers this topic thoroughly:

- [I don't understand. Why not use a different a programming language?](http://www.oilshell.org/blog/2018/01/28.html#i-dont-understand-why-not-use-a-different-a-programming-language)
- [Shouldn't we discourage people from writing shell scripts?](http://www.oilshell.org/blog/2018/01/28.html#shouldnt-we-discourage-people-from-writing-shell-scripts)
- [Shouldn't scripts over 100 lines be rewritten in Python or Ruby?](http://www.oilshell.org/blog/2018/01/28.html#shouldnt-scripts-over-100-lines-be-rewritten-in-python-or-ruby)

Be sure to check out [Oil](http://www.oilshell.org/) in more detail if you can,
it's a very impressive project.

# Usage

We all need to start somewhere, in this section you will se on how to use every functionality in bash++.

## Getting started

To get started, create a bash script (or an existing one). Add the following shebang at the start of the file so that bash can know what file you use.

```sh
#!/bin/bash
```

After you have added the shebang, chmod the main script with:

```sh
chmod +x [SCRIPT_NAME].sh
```

Then, you can just simply run the script as:

```
./[SCRIPT_NAME].sh
```

*NOTE*: Replace `[SCRIPT_NAME]` with your main bash script.

<p align="right">(<a href="#top">back to top</a>)</p>

## Bootstrap the project

To bootstrap your script you will need to source the Import script in your libs folder.

```bash
. "${BASHPP_LIBS}/Import.sh" # Source bash++
```

**NOTE**: Only do this step *once* (aka in the main script). and you will need to put in at the top of the file.
<p align="right">(<a href="#top">back to top</a>)</p>

## Functionalities

Humans need help to learn something new, that is why in this section all bash++ functionalities will be explained with an example.

### Import

Normal bash developers will use `.` or `source` to *'import'* a bash script. Professional Bash++ developers will use the import function.

The Import function will let you choose more variation of sourcing methods that some developers will kill to have that. Apart from it giving more functionality it also creates new (or experienced) bash users a better syntax reading.

The following code is the function declaration for `import`:

```sh
# ImportService::Import (import)
#
# Usage:
#   import MyFile
#   import System # Builtin module
#   import github:mauro-balades/bash-plusplus
#   import https://example.com/script.sh
#   import script1 script2 ...
#
# Description:
#   This function is used to import your bash script.
#   The function is a replacement for "source" since
#   it contains more functionality and it makes the
#   code prettier
#
# Arguments:
#   [...any] scripts: Bash scripts to be imported
ImportService::Import() {
  ...
}
```

As you can see from the function declaration, import can be used in different ways such as:

* Sourcing Files.
* Sourcing Multiple Files.
* Sourcing Urls.
* Sourcing Github paths.
* Sourcing Builtin modules.
* And it adds a variation of bash scripts paths to check.

Description:
* This function is used to import your bash script. The function is a replacement for "source" since it contains more functionality and it makes the code prettier

Usage:

* `import MyFile`
  * checks for:
    * MyFile
    * $( pwd )/MyFile
    * $( pwd )/MyFile.sh
    * $( BASHPP_LIBS )/MyFile
    * $( BASHPP_LIBS )/MyFile.sh
    * /usr/lib/MyFile
    * /usr/lib/MyFile.sh
    * /opt/MyFile
    * /opt/MyFile.sh
    * /usr/share/MyFile
    * /usr/share/MyFile.sh
    * /usr/local/lib/MyFile
    * /usr/local/lib/MyFile.sh
    * $HOME/.local/lib/MyFile
    * $HOME/.local/lib/MyFile.sh
    * $HOME/.local/share/MyFile
    * $HOME/.local/share/MyFile.sh
* `import github:mauro-balades/bash-plusplus/...`
  * Imports bash file from the `raw.githubusercontent.com` domain.
  * Notice how it starts with `github:`
* `import https://example.com/my/bash/script.sh`
  * Sources a fetched file from an URL.
    * With `curl`
    * If `curl` does not exists, it will try with `wget`
* `import myfile1 myfile2 myfile3`
  * Capable to source multiple files checking same files as the `import MyFile` example at the top. (each file is checked if it is a github URL a normal URL)

**NOTE:** It adds the script to an array of imported files. If you get an error saying that a file has already been sourced, remove that file from the import function since it already exists.

<p align="right">(<a href="#top">back to top</a>)</p>

#### Import's extended API

Bash++ also exports some extra features from the import API.

```bash
alias import="ImportService::Import"

# Overrides
alias .="ImportService::SimpleImport"
alias source="ImportService::SimpleImport"

# Extending the API
alias import.url="ImportService::ImportUrl"
alias import.github="ImportService::ImportGitHub"
alias import.simple="ImportService::SimpleImport" # Same as source and .

# Utility functions
alias import.exists="ImportService::Exists"
alias import.nexists="ImportService::NExists"

alias import.addm="ImportService::AddModule"
```

* `.` and `source` overridden with the `ImportService.SimpleImport (import.simple)` function. `import.simple` is basically the same as `import` except it does not support multiple files.
* `import.url` and `import.github` are the functions used in `import` except for the `import.github` function you don't need the `github:` prefix. ( It does not support multiple files ).
* `import.exists` and `import.nexists` this function returns a `1` if a module exists in the `sourced files` array. `nexists` returns `0` if it exists.
* `import.addm`. This function takes a string as a parameter and adds that module to the array.
  * *It does not source the file.*

- [Examples](./examples/import) on how to use `import`

Feel free to check out the `src/Import.sh` file to see each function declaration (it's description, arguments and usage).

<p align="right">(<a href="#top">back to top</a>)</p>

### Classes

Classes are the main purpose of this project. To create a class, you will need to import a built-in module called `Classes`

```sh

# BOOTSTRAP ALREADY DONE ABOVE (IMAGINE)

import Classes
```

To define a class, it is like defining a normal variable except you have "attributes" inside it.


```sh

# BOOTSTRAP ALREADY DONE ABOVE (IMAGINE)

import Classes

MyClass=(

  function __new__ # When class is initiated
  function __delete__ # At the end of the script this is called

  function hello
  function hi = MyClass::different_function # If you call the function "hi", it will actually call MyClass::different_function

  declare name
) # Class called "MyClass"
```

Great, you have successfully declared a class (joke). To add functionality, how about declaring what the function will do. By the way, functions `__new__` and `__delete__` are completely optional.

```sh

# BOOTSTRAP ALREADY DONE ABOVE (IMAGINE)

import Classes

MyClass=(

  function __new__ # When class is initiated
  function __delete__ # At the end of the script this is called

  function hello
  function hi = MyClass::different_function # If you call the function "hi", it will actually call MyClass::different_function

  declare name
) # Class called "MyClass"

MyClass::__new__() {
  # Get the "self" value
  # Explained in the paragraph bellow.
  local self=$1
  shift

  echo "class has inited"

  # Set name to the first argument we get
  # NOTE that name is declared above
  # with the declare keyword
  #
  # "$1" was the self argument
  # but now, we shifter so that function
  # can hav arguments like a normal function
  $self.name= "$1"
}

MyClass::__delete__() {
  echo "Good Bye!"
}

MyClass::hello() {
  local self=$1
  shift

  NAME=$($self.name)
  echo "Hello, $NAME"
}

# Called with the "hi" function
MyClass::different_function() {
  local self=$1
  shift

  echo "Hi, $($self.name)"
}
```

* `the self argument`. This argument is used for people to access class' variables. An example has been done above with the variable `name`. This argument is the first argument, so you can access it in `$1`
* To declare a variable inside a class, you will need to declare with the `declare` keyword (you can declare an array using `-a` as an argument).
* To change a variable's value, a function has been declared which is the following:

  ```
  $self.[VARIABLE_NAME]= "[VALUE]"
  ```

  Note that the `=` sign is not separated from the function name.
* When user inits a class, arguments can be passed to the `__new__` function. (and same with all functions)

<p align="right">(<a href="#top">back to top</a>)</p>

#### Initiate a class

To create a new instance of a class, you will use the `new` function. In the new function, you need to add a class name, a new variable in which it is going to be created with that name and arguments that can be passed to the `__new__` function.

Example (with context of the last example above):

```sh
#   | Class name     | Arguments passed to __new__ (can be infinite)
new MyClass my_class Rob
# ^         ^ new var to create with class instance
```

<p align="right">(<a href="#top">back to top</a>)</p>

#### Call class' attributes

When you have created a new instance of a class, a variable is made so that you can access this functions and variables.

example:

```sh
$my_class.hello # arguments separated by spaces
```

and to access class' variables:

```bash
VAR=$($my_class.name)
```

- See [examples on classes](./examples/class/)

<p align="right">(<a href="#top">back to top</a>)</p>

### .env

To import enviromental variables, you will need to include the dotenv module.

```bash
import dotenv
```

This will give you acces to the `load_dotenv` function. This functions has 1 optional parameter. That paramenter is the name of your `.env` file.

```bash
load_dotenv

# or
load_dotenv "path/to/.env"
```

<p align="right">(<a href="#top">back to top</a>)</p>


# License

```
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

```

<p align="right">(<a href="#top">back to top</a>)</p>
