#!/usr/bin/env bash

find src -type f -name '*.pm' -exec podchecker {} \;
