# Feature Backlog

_Last Updated: 2026-11-01, 07:19am_

- [ ] `TextFiles` Module
  - [ ] `TextFiles::LogFileParsing`
    - [x] Log type counter
    - [x] Log type filter (works like UNIX `grep` but more features(?))
    - [ ] Log file validator
      - Validates log lines against a provided RegEx format
  - [ ] `TextFiles::ParseCSV`
    - [ ] `validate_csv()`
      - Validates that a file is a valid `.csv` file
  - [ ] `TextFiles::Simple`
    - [x] `can_open()` subroutine
    - [x] `cant_open()` subroutine
- [ ] `Arrays` Module
  - [ ] `Arrays::Simple`
    - [ ] `is_empty()` subroutine
    - [ ] `isnt_empty()` subroutine
    - [ ] `clear()` subroutine
      - Empties out an array
    - [ ] `populate()` subroutine
      - Appends items to an array using a list of arbitrary arguments
  - [ ] `Arrays::Sets`
    - [ ] Move `union()` subroutine
    - [ ] `intersection()` subroutine
    - [ ] `is_subset()` subroutine
    - [ ] `difference()` subroutine
    - [ ] `symmetric_difference()` subroutine
