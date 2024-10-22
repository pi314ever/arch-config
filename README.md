# Personal Arch Configuration

This is my personal Arch Linux configuration. It includes my dotfiles, scripts, and other helpers for replicating a similar environment.

## Prerequisites

- Arch Linux (Set up with [installation guilde](https://wiki.archlinux.org/title/installation_guide))
  - Complete all steps up to `arch-chroot`.
- `git`
- `python`
- `poetry`
- `make`
- A wifi connection

### Step-by-step Arch Installation

This step-by-step guide follows the [Arch Linux installation guide](https://wiki.archlinux.org/title/installation_guide) with configuration specifically for personal use.

1. Boot into the Arch Linux installation media.
2. Connect to the internet.

   - For wired connections, no additional steps are needed.
   - For wireless connections, set up with `iw dev wlan0 connect <SSID>`.

3. Update the system clock to PST timezone.

   ```bash
   timedatectl set-timezone US/Pacific
   ```

4. Partition the disks with `fdisk`. Currently, the disk partition assumes the following mounts:

   - `/`: Main root partition on boot drive. Includes a swapfile at `/swapfile`.
   - `/boot`: Boot partition on boot drive.
   - `/data`: Data partition on separate data drive (likely SSD).

5. Format the partitions using `mkfs`.

   ```bash
   # For ext4 partitions (/ and /data)
   mkfs.ext4 <partition>

   # For FAT32 partition (/boot)
   mkfs.fat -F32 <partition>
   ```

6. Mount the partitions with respect to previously defined mount points, adding `--mkdir` to new directories.

   ```bash
   mount <root_partition> /mnt
   mount --mkdir <boot_partition> /mnt/boot
   mount --mkdir <data_partition> /mnt/data
   ```

7. Install essential packages.

   ```bash
   pacstrap -K /mnt base linux linux-firmware vim git networkmanager make
   ```

8. Generate a `fstab` file

   ```bash
   genfstab -U /mnt >> /mnt/etc/fstab
   ```

9. Chroot into the new system.

   ```bash
   arch-chroot /mnt
   ```

10. (Optional) Set up a swapfile.

    ```bash
    dd if=/dev/zero of=/swapfile bs=1M count=4096 status=progress
    chmod 600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    ```

### Python Environment

Currently, my preference for Python version and package management uses `pyenv` for version management, `venv` for optional local environments, and `poetry` for package management. The following steps outline the installation of these tools.

1. Install `pyenv` and `pyenv-virtualenv` from source.

   ```bash
   curl https://pyenv.run | bash
   ```

2. Add the necessary configuration to the shell profile and refresh the shell. For bash:

   ```bash
   echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
   echo 'command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
   echo 'eval "$(pyenv init -)"' >> ~/.bashrc
   source ~/.bashrc
   ```

3. Install Python build dependencies

   ```bash
   pacman -S --needed base-devel openssl zlib xz tk
   ```

4. Install Python versions with `pyenv`.

   ```bash
   pyenv install 3.12.7
   ```

5. Create a virtual environment.

   ```bash
   # WIth pyenv-virtualenv (preferred)
   pyenv virtualenv 3.12.7 arch-config
   # With venv
   # python -m venv .venv/
   ```

## Installation

### Script Installation

1. Clone the repository: `git clone https://github.com/pi314ever/arch-config.git`
2. Navigate to the repository: `cd arch-config`
3. Install dependencies and script through poetry: `poetry install`

## Usage

### Fresh Install of All Configurations

1. Run the script: `arch-config install all --user <username> --hostname <hostname> ...`

- For full list of options, run `arch-config help all`
