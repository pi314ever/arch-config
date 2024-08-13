NAME := "arch_config"
POETRY := $(shell command -v poetry 2> /dev/null)

.PHONY: poetry-check
poetry-check:
	@if [ -z $(POETRY) ]; then echo "Poetry could not be found. See https://python-poetry.org/docs/"; exit 2; fi

.PHONY: install
install: pyproject.toml poetry-check
	$(POETRY) install

.PHONY: style
style: install-requirements-dev
	ruff check --fix
	ruff format

.PHONY: install-requirements-dev
install-requirements-dev: pyproject.toml poetry-check
	$(POETRY) install --with dev

.PHONY: test
test: install-requirements-dev poetry-check
	$(POETRY) run pytest

.PHONY: clean
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} \+
	find . -type d -name ".pytest_cache" -exec rm -rf {} \+
	find . -type d -name ".ruff_cache" -exec rm -rf {} \+
