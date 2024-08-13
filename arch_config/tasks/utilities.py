from pathlib import Path

from ..args import Args, ArgsEnum
from ..utils.system import check_or_add, run_command
from ..utils.task import Result, Task, register_task


@register_task
class NoBell(Task):
    name = "no-bell"
    description = "Disables the terminal bell sound."

    def run(self, args: "Args") -> Result:
        check_or_add("blacklist pcspkr", Path("/etc/modprobe.d/nobell.conf"))
        return Result(True)

    def check(self, args: "Args") -> Result:
        return Result(False, "Not implemented")


@register_task
class Timezone(Task):
    name = "timezone"
    description = "Sets the timezone of the system."
    required_args = [ArgsEnum.TIMEZONE]

    def run(self, args: "Args") -> Result:
        if len(args.timezone.split("/")) != 2:
            return Result(
                False,
                f"Invalid timezone format: {args.timezone}. Must be in the format 'Continent/City'",
            )
        output = run_command(
            ["ln", "-sf", f"/usr/share/zoneinfo/{args.timezone}", "/etc/localtime"]
        )
        return output.to_result()

    def check(self, args: "Args") -> Result:
        return Result(False, "Not implemented")


@register_task
class Paru(Task):
    name = "paru"
    description = "Installs Paru, an AUR helper."

    def run(self, args: "Args") -> Result:
        run_command(["git", "clone", "https://aur.archlinux.org/paru.git", "/tmp/paru"])
        run_command(["makepkg", "-si"], cwd=Path("/tmp/paru"))
        run_command(["rm", "-rf", "/tmp/paru"])
        return Result(True)

    def check(self, args: "Args") -> Result:
        return Result(False, "Not implemented")
