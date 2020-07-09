# TallyAssist

TallyAssist is an open source Flutter-based template for a business assistant application. It has been designed to use [Google Firebase](firebase.google.com/) as backend.

The project had started out with an intent to become a mobile interface for [Tally](https://tallysolutions.com/) (India's premier accounting software). Over time, it refined to become a more focused business assistant application. For more details, check out this blog post announcing the project's release.

The project was developed and tested for Android. Please feel free to contribute and open PRs for iOS support.

*Note: The codebase was developed in fast iterations while performing user research. There are instances where it can be improved and modularized. This is especially true for the data model and implementation of state management using [provider](https://pub.dev/packages/provider). If you come across such cases and want to contribute improvements, consider opening an issue or PR.*

## Demo App

<!-- [Play Store BETA]() -->

## Features

- Invoice generator
- Party (supplier/customer) statement generator
- Invoice/voucher viewer
- Business dashboard
- Report screens for account payable, receivables, stock items

### Screenshots

<p align="center">
    <img src="https://github.com/TallyAssist/TallyAssist/blob/master/assets/images/PS-2.png" alt="Ledger statements" width="200"/>
    <img src="https://github.com/TallyAssist/TallyAssist/blob/master/assets/images/PS-1.png" alt="GST Invoices" width="200"/>
    <img src="https://github.com/TallyAssist/TallyAssist/blob/master/assets/images/PS-3.png" alt="Invoice PDFs" width="200"/>
    <img src="https://github.com/TallyAssist/TallyAssist/blob/master/assets/images/PS-4.png" alt="Dashboard" width="200"/>
    <img src="https://github.com/TallyAssist/TallyAssist/blob/master/assets/images/PS-5.png" alt="Menu" width="200"/>
</p>

## Setup

Start out by [cloning this repo](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository).

### Flutter

- Install Flutter by following the [official documentation](https://flutter.dev/docs/get-started/install) if you haven't.
- Using VSCode or Android Studio as your choice of IDEs is highly recommended. You can find official Flutter documentation for getting up and running with them [here](https://flutter.dev/docs/development/tools).
- Make sure that you are on Flutter's `stable` [channel](https://flutter.dev/docs/development/tools/sdk/upgrading#switching-flutter-channels)
  - `flutter channel stable`

### Firebase

- Default app name is `com.example.tassist`. Choose your app's name and replace the default name in the following files.
  - `android/app/build.gradle`
  - `android/app/src/main/AndroidManifest.xml`
  - `android/app/src/debug/AndroidManifest.xml`
  - `android/app/src/profile/AndroidManifest.xml`
  - `android/app/src/main/kotlin/com/example/MainActivity.kt`
- Set up a Firebase project, generate a configuration file and copy the file to this repo by following Steps 1-3 listed [here](https://firebase.google.com/docs/flutter/setup?platform=android).
- Enable `Email/Password` authentication method in the Firebase console. You can find it under `Develop`>`Authentication`>`Sign-in method`.
- Enable [Cloud Firestore](https://firebase.google.com/docs/firestore) by going to `Develop`>`Database`.

## Development

### Local

- Make sure that a physical device or emulator is connected to your system.
- [Run](https://flutter.dev/docs/get-started/test-drive?tab=terminal) the application.

*Note: When running the application for the first time, you will encounter an exception related to Firebase indices. Fixing it is as easy as clicking on the link that shows up, as described in this [Stack Overflow answer](https://stackoverflow.com/a/47972492/2557831).*

### Build

#### Coming Soon

- Unsigned

- Signed

## 🤓 Author(s)

- [**Richa Verma**](https://github.com/RichaVerma/)
- [**Akash Tandon**](https://github.com/analyticalmonk)

We would also like to thank [**Ishaan Kakkar**](https://github.com/ishaan1995) for all his guidance. 

## 🔖 LICENCE

[MIT](https://github.com/TallyAssist/TallyAssist/blob/master/LICENSE)
