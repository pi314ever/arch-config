from ..args import Args
from ..utils.task import Result, Task, register_task


@register_task
class Zsh(Task):
    name = "zsh"
    description = "Installs Zsh and sets up configuration files."

    def run(self, args: "Args") -> Result:
        return Result(False, "Not implemented")

    def check(self, args: "Args") -> Result:
        return Result(False, "Not implemented")
