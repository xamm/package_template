# CLEAN
.PHONY: clean
clean:
	rm -rf build
	rm -rf dist
	rm -rf htmlcov
	rm -rf lightning_logs
	find . -name "*.egg-info" -exec rm -rf {} +
	find . -name "__pycache__" -exec rm -rf {} +
	find . -name ".mypy_cache" -exec rm -rf {} +
	find . -name ".pytest_cache" -exec rm -rf {} +

# FREEZE
.PHONY: freeze
freeze:
	pip-compile setup.cfg --resolver=backtracking

# INSTALL
.PHONY: upgrade
upgrade:
	pip install --upgrade pip

.PHONY: install
install: clean upgrade
	pip install build wheel
	pip install .

.PHONY: develop
develop: clean upgrade
	pip install build wheel
	pip install -e .[dev]
	pre-commit install

# BUILD
.PHONY: build
build: clean
	python -m build

# TEST
.PHONY: test
test:
	pytest --disable-warnings

.PHONY: coverage
coverage:
	pytest --disable-warnings --cov-report=xml --cov=.

# LINT
.PHONY: lint
lint:
	mypy package_name tests
	isort -c package_name tests
	pylint package_name tests
	flake8 package_name tests
	autoflake -c -r package_name tests

# FORMAT
.PHONY: black
black:
	black package_name tests

.PHONY: isort
isort:
	isort package_name tests

.PHONY: autoflake
autoflake:
	autoflake --in-place --remove-all-unused-imports --remove-unused-variables --recursive package_name tests

.PHONY: format
format: clean black isort autoflake
