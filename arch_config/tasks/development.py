from pathlib import Path

from loguru import logger

from ..args import Args, ArgsEnum
from ..utils.system import pacman_install, run_command
from ..utils.task import Result, Task, register_task


@register_task
class Python(Task):
    name = "python"
    description = "Installs Python and sets up development environment."

    def run(self, args: "Args") -> Result:
        assert args.dots_dir is not None, "No dots directory provided."
        pacman_install(["python"]).expect_success("Failed to install Python")
        return Result(False, "Not implemented")

    def check(self, args: "Args") -> Result:
        return Result(False, "Not implemented")


@register_task
class Neovim(Task):
    name = "neovim"
    description = "Installs Neovim and sets up configuration files."
    required_args = [ArgsEnum.DOTS_DIR]

    config_dir = (Path.home() / ".config" / "nvim").resolve()

    def run(self, args: "Args") -> Result:
        assert args.dots_dir is not None, "No dots directory provided."
        logger.info("Running Neovim task")
        pacman_install(["neovim"]).expect_success("Failed to install Neovim")

        # Link configs
        if self.config_dir.exists() and self.config_dir.is_symlink():
            logger.info(
                f"Removing existing Neovim config link pointing to: {self.config_dir.readlink()}"
            )
            self.config_dir.unlink()
        elif self.config_dir.exists():
            logger.warning(
                f"Neovim config directory already exists at: {self.config_dir}"
            )
            return Result(False, "Neovim config directory already exists")
        nvim_config = (args.dots_dir / "config" / "nvim").resolve()
        run_command(
            ["ln", "-s", str(nvim_config), str(self.config_dir)], shell=True
        ).expect_success("Failed to link Neovim config")

        assert self.check(args).success, "Neovim setup failed"

        return Result(True)

    def check(self, args: "Args") -> Result:
        # Check if Neovim is installed
        result = run_command(["nvim", "--version"])
        if result.error:
            return Result(False, "Neovim is not installed")

        # Check if Neovim config is linked
        if not self.config_dir.is_symlink():
            return Result(False, "Neovim config is not linked")

        return Result(True)
