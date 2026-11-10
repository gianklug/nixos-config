#!/usr/bin/env bash
nixos-rebuild switch --flake .#`hostname` --show-trace --print-build-logs --sudo
