from ..args import Args
from ..utils.task import Result, Task, register_task
from ..utils.system import pacman_install


@register_task
class Neovim(Task):
    name = "neovim"
    description = "Installs Neovim and sets up configuration files."

    def run(self, args: "Args") -> Result:
        pacman_install(["neovim"])
        return Result(False, "Not implemented")

    def check(self, args: "Args") -> Result:
        return Result(False, "Not implemented")
