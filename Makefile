
SHELL := /bin/bash
.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo

clean: ## Clean the project using cargo
	@echo "Cleaning the project..."
	cargo clean

build: ## Build the project using cargo
	@echo "Building the project..."
	cargo build

lint: ## Lint the project using cargo
	cargo clippy


format: ## Format the project using cargo
	@rustup component add rustfmt> /dev/null
	cargo fmt

bump: ## Bump the version using cargo
	@echo "Current version is $(shell cargo pkgid | cut -d# -f2)"
	@read -p "Enter new version: " version; \
	updated_version=$$(cargo pkgid | cut -d# -f2 | sed 's/^[^0-9]*//'); \
	if [ "$$version" = "$$updated_version" ]; then \
		echo "Version is already set to $$version"; \
	else \
		cargo pkgid | cut -d# -f2 | sed 's/^[^0-9]*//' | xargs -I {} cargo pkgid -- --set-version $$version; \
		echo "Version updated to $$version"; \
	fi



