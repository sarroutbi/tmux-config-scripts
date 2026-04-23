# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains a collection of tmux session launcher scripts. Each `tmux_*.sh` script creates a pre-configured tmux session with named windows tailored to a specific project (e.g., clevis, keylime, ramalama). All scripts share a common tmux configuration via `tmux.common.conf`.

## Script Pattern

Every tmux script follows the same structure:
1. Takes two arguments: a working directory (`$1`) and a session name (`$2`)
2. Validates both arguments, exiting on failure
3. Creates a detached tmux session, sources `~/tmuxes/tmux.common.conf`, creates project-specific named windows, then attaches
4. `tmux_generic.sh` is the minimal template — use it as a starting point for new scripts

## CI/Linting

- **ShellCheck**: Runs on all shell scripts on push/PR to `main`. All scripts must pass `shellcheck`.
- **Spellcheck**: Runs on `*.md` files only (via `pyspelling`). Custom words go in `.wordlist.txt`.
- Run ShellCheck locally: `shellcheck tmux_*.sh`

## Conventions

- Scripts use `#!/bin/sh` (POSIX shell), not bash (except `tmux_test.sh`)
- ISC license header on every script
- `tmux.common.conf` rebinds the prefix key to `Ctrl+T` (not `Ctrl+B`)
