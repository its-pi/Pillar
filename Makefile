.PHONY: generate generate-no-open clean unit-test ui-test all-test

generate:
	tuist generate

generate-no-open:
	tuist generate --no-open

clean:
	tuist clean

unit-test:
	tuist test Pillar-UnitTests
	@echo ""
	@echo "---"
	@echo "generate project"
	@echo "---"
	@echo ""
	tuist generate --no-open

ui-test:
	tuist test Pillar-UiTests
	@echo ""
	@echo "---"
	@echo "generate project"
	@echo "---"
	@echo ""
	tuist generate --no-open

all-test:
	tuist test Pillar-AllTests
	@echo ""
	@echo "---"
	@echo "generate project"
	@echo "---"
	@echo ""
	tuist generate --no-open
