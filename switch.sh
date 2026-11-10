#!/bin/bash
nixos-rebuild switch --flake .#travel --show-trace --print-build-logs --sudo
