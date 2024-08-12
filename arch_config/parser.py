import argparse

from .args import ArgsEnum
from .tasks import *  # noqa: F403
from .utils.task import TASKS


def get_parser():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.ArgumentDefaultsHelpFormatter
    )

    command_parser = parser.add_subparsers(dest="command", required=True)
    help_parser = command_parser.add_parser(
        "help", help="Shows help message for a task"
    )
    install_parser = command_parser.add_parser(
        "install", help="Install task(s) on the system"
    )
    dry_run_parser = command_parser.add_parser(
        "dry-run", help="Simulate the installation of task(s)"
    )
    check_parser = command_parser.add_parser(
        "check", help="Check if task(s) are installed"
    )
    command_parser.add_parser("list", help="List all available tasks")

    for subparser in [help_parser, install_parser, dry_run_parser, check_parser]:
        subparser.add_argument(
            "tasks",
            nargs="+",
            help="Task(s) to install, simulate, or check",
            choices=TASKS.keys(),
        )
    for subparser in [install_parser, dry_run_parser, check_parser]:
        ArgsEnum.add_to_parser(list(ArgsEnum), subparser)

    for subparser in [install_parser, dry_run_parser]:
        subparser.add_argument(
            "--overwrite", action="store_true", help="Overwrite existing files"
        )
    install_parser.add_argument(
        "--dry_run", action="store_true", help="Simulate the installation of task(s)"
    )

    return parser
