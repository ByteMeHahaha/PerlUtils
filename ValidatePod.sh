#!/usr/bin/env bash

(
	cd src || exit

	for perlFile in lib/Utils/**/*.pm; do
		podchecker "$perlFile" || true
		# "|| true" prevents failing if there's no POD comments
	done
)
