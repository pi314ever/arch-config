# Personal Arch Configuration

This is my personal Arch Linux configuration. It includes my dotfiles, scripts, and other helpers for replicating a similar environment.

## Prerequisites

- Arch Linux (Set up with [installation guilde](https://wiki.archlinux.org/title/installation_guide))
  - Complete all steps up to `arch-chroot`.
- `git`
- `python`
- `poetry`
- A wifi connection

## Installation

### Script Installation

1. Clone the repository: `git clone https://github.com/pi314ever/arch-config.git`
2. Navigate to the repository: `cd arch-config`
3. Install dependencies and script through poetry: `poetry install`


## Usage

### Fresh Install of All Configurations

1. Run the script: `arch-config install all --user <username> --hostname <hostname> ...`
- For full list of options, run `arch-config help all`
