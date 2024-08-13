import re
import subprocess
from dataclasses import dataclass
from pathlib import Path

from loguru import logger

from .task import Result


@dataclass
class CommandOutput:
    returncode: int
    stdout: str = ""
    stderr: str = ""

    def to_result(self) -> "Result":
        success = self.returncode == 0
        return Result(success, "" if success else self.stderr)

    @property
    def success(self) -> bool:
        return self.returncode == 0


DRY_RUN = False


def run_command(
    command: list[str], *args, dry_run: bool = DRY_RUN, **kwargs
) -> CommandOutput:
    """Runs a command in the shell."""
    logger.info(
        f"Running command{' (dry run)' if dry_run else ''}: "
        + " ".join(command)
        + f" with args {args} and kwargs {kwargs}"
    )
    if dry_run:
        logger.info("Dry run, not executing command.")
        return CommandOutput(0, "", "")
    else:
        result = subprocess.run(command, *args, capture_output=True, **kwargs)
        return CommandOutput(
            result.returncode,
            result.stdout.decode(),
            result.stderr.decode(),
        )


def check_line(line: str, file: Path) -> bool:
    """Checks if a line is in a file."""
    line = line.strip()
    logger.info(f"Checking line in {file}: {line}")
    if not file.exists():
        logger.debug(f"File {file} does not exist.")
        return False
    with open(file, "r") as f:
        if line in f.read().strip():
            logger.debug(f"Line {line} found in {file}.")
            return True
    logger.debug(f"Line {line} not found in {file}.")
    return False


def check_or_add(line: str, file: Path):
    """Checks if a line is in a file, and adds it if it isn't. In dry run mode, only checks if the line is in the file."""
    line = line.strip()
    if check_line(line, file):
        logger.debug("Line already exists in file.")
        return
    logger.info("Appending line to end of file.")
    if DRY_RUN:
        logger.debug("Dry run, not appending line.")
        return
    with open(file, "a") as f:
        f.write(line + "\n")


def pacman_install(package_names: list[str]) -> CommandOutput:
    """Installs a package using a package manager."""
    return run_command(["pacman", "-S", "--noconfirm"] + package_names)


def pacman_is_installed(package: str) -> bool:
    """Checks if a package is installed."""
    output = run_command(
        ["pacman", "-Q", package], dry_run=False
    )  # Force to query the system to alert dependencies
    exists_regex = rf"^{package} [0-9.-]"
    if re.search(exists_regex, output.stdout) is not None:
        return True
    return False


def aur_install(package_names: list[str], helper: str = "paru") -> CommandOutput:
    """Installs an AUR package."""
    return run_command([helper, "-S", "--noconfirm"] + package_names)


def aur_is_installed(package: str, helper: str = "paru") -> bool:
    """Checks if an AUR package is installed."""
    output = run_command([helper, "-Q", package], dry_run=False)
    exists_regex = rf"^{package} [0-9.-]"
    if re.search(exists_regex, output.stdout) is not None:
        return True
    return False
