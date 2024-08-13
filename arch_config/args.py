import argparse
from enum import Enum
from pathlib import Path
from typing import Optional

from pydantic import BaseModel


class ArgsEnum(Enum):
    USERNAME = (
        ["--username"],
        {"help": "The username of the user to create", "type": str},
    )
    DOTS_DIR = (
        ["--dots_dir"],
        {
            "help": "The directory where the dotfiles are stored. See README for more info on dots directory structure.",
            "type": Path,
        },
    )
    HOSTNAME = (
        ["--hostname"],
        {"help": "The hostname of the system", "type": str},
    )
    GROUPS = (
        ["--groups"],
        {
            "help": "The groups to add the user to",
            "type": str,
            "nargs": "+",
            "default": [],
        },
    )
    LOCALE = (
        ["--locale"],
        {"help": "The locale of the system", "type": str, "default": "en_US.UTF-8"},
    )
    TIMEZONE = (
        ["--timezone"],
        {"help": "The timezone of the system", "type": str, "default": "US/Pacific"},
    )

    @staticmethod
    def add_to_parser(args: list["ArgsEnum"], parser: argparse.ArgumentParser):
        for arg in args:
            if "default" not in arg.value[1] and "required" not in arg.value[1]:
                arg.value[1]["default"] = None
            parser.add_argument(*arg.value[0], **arg.value[1])


class Args(BaseModel):
    tasks: list[str]
    username: Optional[str]
    dots_dir: Optional[Path]
    hostname: Optional[str]
    groups: Optional[list[str]]
    locale: str
    timezone: str
    overwrite: bool = False
    dry_run: bool = False

    def model_post_init(self, __context) -> None:
        self.tasks = list(set(self.tasks))
