# PerlUtils

Utility modules written in Perl, for Perl.

- Author: Ethan Kletschke
- Version: `0.0.7`
- Developed on: Ubuntu (WSL)
- License: MIT
- Project metadata file: [`project.yaml`](./meta/project.yaml)

---

- [PerlUtils](#perlutils)
  - [About This Project](#about-this-project)
    - [Features](#features)
  - [Running the Module Tests](#running-the-module-tests)
  - [Validating the POD Documentation](#validating-the-pod-documentation)

---

## About This Project

PerlUtils is a library of Perl modules (created mostly as a skills reference)
that currently provides utility subroutines for text-file handling and array handling,
and is planned to also provide OS subroutines (i.e., making directories, running specific
utility commands, etc.), text processing subroutines, and other

### Features

- Various utility subroutines aimed at simplifing Perl programs
  - Array subroutines (planned), such as:
    - `is_empty()`
    - `clear()`
    - `populate()`
  - Mathematical set subroutines (i.e., `union()`, `intersection()`, etc.)
  - Text processing subroutines
- Extensive POD documentation validated with CI/CD (using `podchecker`)
- Comprehensive `Test::More` testing suite run with `prove`
- Bash scripts that run the testing suite and validate POD documentation

## Running the Module Tests

To run the module tests, navigate to the `src/` directory and run the following command:

```bash
prove -lv t/*
```

Or in the root directory of the project, run the provided Bash script:

```bash
./RunUnitTests.sh
```

Both will run the provided module tests in the `src/t/` directory using `prove`.


## Validating the POD Documentation

To validate the project's POD documentation, run this in the project's root directory:

```bash
find src -type f -name '*.pm' -exec podchecker {} \;
```

This will:

1. Find every Perl module file ending with `.pm`
2. Execute the `podchecker` command against each `.pm` file
3. Display the output of the validation for each file

Alternatively, you can also run the provided Bash script:

```bash
./ValidatePod.sh
```
