# GymApp

Simple Gym App to track weights and sets

## Running

Open `GymApp.xcodeproj` in Xcode 17 or newer and run the `GymApp` scheme on an iOS 17+ simulator or device.

Command-line simulator build:

```sh
xcodebuild -project GymApp.xcodeproj -scheme GymApp -configuration Debug -sdk iphonesimulator -derivedDataPath ./DerivedData CODE_SIGNING_ALLOWED=NO build
```

## Notes

- The app stores workout names and exercise data in `UserDefaults`.
- A fresh install starts with `Demo Workout` so the app has content for demonstration.
- This branch keeps the original UI and data model mostly intact, with small updates for current SwiftUI navigation and safer delete/remove behavior.
