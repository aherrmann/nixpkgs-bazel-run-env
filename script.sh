#!/usr/bin/env bash
echo "$PATH" >"$1"
type readlink >>"$1"
