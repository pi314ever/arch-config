from arch_installer.parser import get_parser

if __name__ == "__main__":
    args = get_parser().parse_args()
    print(args.tasks)
    print(args)
