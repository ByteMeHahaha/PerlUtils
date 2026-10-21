#!/usr/bin/env bash

(
	cd src || exit
	prove -lv t/*
)
