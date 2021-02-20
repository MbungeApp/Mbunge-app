run:
	flutter run

release: 
	flutter build apk --release


fmt:
	flutter format lib && flutter analyze .

apk:
	flutter build apk --release --target-platform android-arm,android-arm64,android-x64 --split-per-abi 

aab:
	flutter build appbundle --release 

load:
	flutter install

mods:
	flutter packages run build_runner build --delete-conflicting-outputs

mods_watch:
	flutter packages run build_runner watch

icons:
	flutter pub run flutter_launcher_icons:main

clean:
	flutter clean

pub:
	flutter pub get

scratch:
	make clean && make pub && make mods && make aab
