<p align="center">
<img src="./logo.png" width="250" />
<h2 align="center">bash ++</h1>
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

# What is bash++ ?

Bash++ is a new way to brin bash to a next level. This framework introduces new functionalities to bash. Some of this functionalities are:

- [ ] Unit testing
- [x] Classes
- [x] Imports
- [ ] Logging
- [ ] Types
- [ ] Errors

* **_and many more!_**

Bash++ is designed so that people could build more complex apps creating better products. Note that this project is for people with experience with bash (not much, just simple understandings and how things usualy work).

When you run `bash++` with bash, the application brakes. This is why you need to add `#!/usr/bash` to the start of the script ([see instructions here]()).

Bash haves it's own module system, so you will have a bash++ folder in your `/usr/libs` directory (just so that you know).

# Installation

To use `bash++` you will (obviously) need to install it. To install it, clone the repo by runing the following command:

```
git clone https://github.com/mauro-balades/bash-plusplus
```

After cloning the repository, `cd` into that directory. Once you are in the directory called `bash-plusplus`. Run the following command to procede with the installation.

*Note that you need to run it in `sudo` mode.*

```
sudo make install
```

When you have installed it, you will see a new directory (usually in `/usr/lib/bash++`). This directory is where all of bash's built-in libraries will be stored.

# Usage

We all need to start somewhere, in this section you will se on how to use every functionaly in bash++.

## Geting started

To get started, create a bash script (or you can already have an existing one). Add the following sheebang (*to all the scripts*) at the start of the file so that bash can know what file you use.

```sh
#!/bin/bash
```

After you have added the sheebang, chmod the main script with:

```sh
chmod +x [SCRIPT_NAME].sh
```

Then, you can just simply run the script as:

```
./[SCRIPT_NAME].sh
```

*NOTE*: Replace `[SCRIPT_NAME]` with your main bash script.

## Bootstrap the project

To bootstrap your script you will need to source the Import scirpt in your libs folder.

```bash
. "${BASHPP_LIBS}/Import.sh # Source bash++
```

**NOTE**: Only do this step *once* (aka in the main script). and you will need to put in at the top of the file.

## Functionalities

Humans need help to learn something new, that is why in this section all bash++ functionalities will be explained with an example.

### Import

Normal bash developers will use `.` or `source` to *'import'* a bash script. Profesional Bash++ developers will use the import function.

The Import function will let you choose more variation of sourcing methods that some developers will kill to have that. Appart from it giving more functionality it also creates new (or experienced) bash users a better syntax reading.

The following code is the function declareation for `import`:

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

As you can see from the function declaration, import can be used in diferent ways such as:

* Sourcing Files.
* Sourcing Multiple Files.
* Sourcing Urls.
* Sourcing Github paths.
* Sourcing Builting modules.
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

* `.` and `source` overrided with the `ImportService.SimpleImport (import.simple)` function. `import.simple` is basically the same as `import` except it does not support multiple files.
* `import.url` and `import.github` are the functions used in `import` except for the `import.github` function you dont need the `github:` prefix. ( It does not support multiple files ).
* `import.exists` and `import.nexists` this function returns a `1` if a module exists in the `sourced files` array. `nexists` returns `0` if it exists.
* `import.addm`. This function takes a string as a parameter and adds that module to the array.
  * *It does not source the file.*

[Examples](./examples/import)

Feel free to check out the `src/Import.sh` file to see each function declaration (it's desciprtion, arguments and usage).
