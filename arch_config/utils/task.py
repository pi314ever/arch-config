"""Defines the abstract class for tasks to allow for a unified logging system."""

from abc import ABC, abstractmethod
from dataclasses import dataclass
from typing import TYPE_CHECKING, Type

if TYPE_CHECKING:
    from ..args import Args, ArgsEnum


@dataclass
class Result:
    success: bool
    message: str = ""


TaskType = Type["Task"]


class Task(ABC):
    name: str
    description: str
    required_args: list["ArgsEnum"] = []
    dependencies: list[str] = []  # List of task names to install

    @abstractmethod
    def run(self, args: "Args") -> Result:
        """
        Installs the task without checking dependencies. Must be implemented by subclasses.
        """

    @abstractmethod
    def check(self, args: "Args") -> Result: ...

    @classmethod
    def help(cls) -> str:
        title = f"{cls.name}: {cls.description}"
        args = [
            f"    {arg.value[0]}: {arg.value[1]['help']}" for arg in cls.required_args
        ]
        return f"{title}\n{'  Arguments:\n' if args else 'No required arguments'}{'\n'.join(args)}"


TASKS: dict[str, Task] = {}


def register_task(task: TaskType) -> TaskType:
    TASKS[task.name] = task()
    return task
