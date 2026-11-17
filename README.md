# Simple Calculator for macOS

A compact native calculator exploring SwiftUI layout and state management.

**Status:** learning prototype. Source published; compilation and runtime behaviour have not yet been verified on macOS. No signed app or DMG release is available.

## Features

- Addition, subtraction, multiplication and division
- Decimal input, sign toggle, percentage conversion and backspace
- Division-by-zero error display
- Compact interface with system appearance support

## Build on a Mac

Requires macOS 13 or later and Xcode Command Line Tools. From the repository directory:

```sh
xcrun swiftc -parse-as-library Calculator.swift -o SimpleCalculator
./SimpleCalculator
```

The current build command produces an executable, not an installable app bundle.

## Design notes

`Calculator.swift` contains the app entry point, SwiftUI view and a small sequential-operation calculator. Operations are evaluated left to right; `%` divides the displayed value by 100. Uses floating-point arithmetic and is not intended for financial calculations.

## Next steps

- [ ] Verify compilation and behaviour on a Mac
- [ ] Extract calculation logic and add arithmetic tests
- [ ] Add keyboard shortcuts
- [ ] Package a signed application

## Development

Created with AI assistance as a learning project. This repository documents its current limitations rather than presenting the prototype as a finished release.
