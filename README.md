# Crypto App

This application connects to [coincap](https://coincap.io/) [API](https://docs.coincap.io/) to get cryptocurrency changes in real time, this project implements __clean architecture__ for organization and [freezed](https://pub.dev/packages/freezed) to use functional programming.

## Installation

Get code using

```
git clone https://github.com/baguilar6174/flutter-crypto-app.git
```

__Step 2__

Install the necessary libraries (this proyect use Flutter 3.7.0 & Dart 2.19.0)

```
flutter pub get
```

__Step 3__

Generate Freezed files

```bash
flutter pub run build_runner build
```

If you have problems to generate freezed files:

`I tried removing l10n.yaml and then flutter clean and flutter packages pub get and it fixed!`

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

__Step 4__

Generate locale strings (en & es)

```bash
flutter gen-l10n
```

Run the app

## My process

### Build with (libs)

- `dio`: Http Client
- `provider`: State management
- `logger`: Create friendly logs in console
- `freezed_annotation`: Annotations for Freezed
- `web_socket_channel`: Allow connections with WS
- `flutter_svg`: Render SVG
- `intl`: Internationalization
- `build_runner`: Generate code
- `freezed`

## Features

- Using Sockets
- Clean Architecture
- Functional programming with Freezed
- Dio Http client, interceptor and logger
- Using Intl to formats and internationalization

### What I learned

- Implement clean architecture with provider
- Using Either class
- Create connection and using Web Sockets
- State management using provider
- Generate classes and entities using Freezed
- `when`, `maybeWhen`, `map`, etc. Functional programming operators
- Listen changes using streams

## Crypto App

<table>
  <tr>
    <td align="center" valign="center"><img src="./media/1.png" width="25%"></td>
  </tr>
 </table>

## Stay in touch

- Website - [www.bryan-aguilar.com](https://www.bryan-aguilar.com/)
- Medium - [baguilar6174](https://baguilar6174.medium.com/)
- LinkeIn - [baguilar6174](https://www.linkedin.com/in/baguilar6174)
