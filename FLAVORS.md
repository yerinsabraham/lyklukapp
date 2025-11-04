# lykluk

LykLuk Mobile App Project Docs

## Run app for both dev and prod - flavor / dart define command

```bash
# Run app for dev / staging
flutter run --flavor dev --dart-define=FLAVOR=dev

# Run app for prod
flutter run --flavor prod --dart-define=FLAVOR=prod
```


## Build apk / aab / ipa for both dev and prod - flavor / dart define command

```bash
# Build apk for dev / staging
f155369


# Build ipa for dev / staging
flutter build ipa --flavor dev --dart-define=FLAVOR=dev

# Build apk for prod
flutter build apk --flavor prod --dart-define=FLAVOR=prod

# Build app bundle for prod
flutter build appbundle --flavor prod --dart-define=FLAVOR=prod

# Build ipa for prod
flutter build ipa --flavor prod --dart-define=FLAVOR=prod

# Obsfucate apk for prod
flutter build apk --release --flavor prod --dart-define=FLAVOR=prod --obfuscate --split-debug-info=/{PROJECT-PATH}/lykluk/debug-info

# Obsfucate apk for dev
flutter build apk --release --flavor dev --dart-define=FLAVOR=dev --obfuscate --split-debug-info=/{PROJECT-PATH}/lykluk/debug-info

# Obsfucate ipa for ios
flutter build ios --release --obfuscate --split-debug-info=/{PROJECT-PATH}/debug-info
```

## Extra Information
```
# Add the BPVod.lic file to Assets directory
assets/ --include the .lic file
```
