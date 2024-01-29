.PHONY: clean format analyze
clean:
	fvm flutter clean
	fvm flutter pub get

format: ## Formats the code
	@echo "|--Formatting the code"
	@fvm flutter pub run import_sorter:main
	@fvm dart format lib .

lint: ## Lints the code
	@echo "|--Verifying code..."
	@fvm flutter analyze . || (echo "Error in project"; exit 1)

build-aab:clean
	fvm flutter build appbundle --release --dart-define=FLAVOR=prod

build-apk:clean
	fvm flutter build apk --release --dart-define=FLAVOR=stg

gen:
	fvm dart run build_runner build --delete-conflicting-outputs