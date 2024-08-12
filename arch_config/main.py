from arch_installer.parser import get_parser
from arch_installer.args import Args, ArgsEnum
from arch_installer.utils.task import TASKS


def main():
    raw_args = get_parser().parse_args()
    if raw_args.command == "help":
        tasks = list(set(raw_args.tasks))
        for task in tasks:
            print(TASKS[task].help())
        return
    args = Args.model_validate(raw_args, from_attributes=True)
    print(args)


if __name__ == "__main__":
    main()
