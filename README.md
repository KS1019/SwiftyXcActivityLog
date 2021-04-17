# SwiftyXcActivityLog
[![Swift Test](https://github.com/KS1019/SwiftyXcActivityLog/actions/workflows/swift.yml/badge.svg)](https://github.com/KS1019/SwiftyXcActivityLog/actions/workflows/swift.yml)
[![Create Release](https://github.com/KS1019/SwiftyXcActivityLog/actions/workflows/main.yml/badge.svg)](https://github.com/KS1019/SwiftyXcActivityLog/actions/workflows/main.yml)

## Install
You can install this package via Swift Package. 

Simply add ```swift.package(name: "SwiftyXcActivityLog", url: "https://github.com/KS1019/SwiftyXcActivityLog", .upToNextMajor(from: "0.0.5"))```
to your dependecies in your Package.swift.

Alternatively, you can add this package via Xcode.

## Usage
In order to access to the log, you write
```swift
let log = XcActivityLog(productName: productName)

// Use this when you want to deal with an array of Execution struct
guard let executions = log.asExecutions() else { return } 

// Use this when you want to deal with an array of String
guard let strArray = log.asStringArray() else { return }
```

## Alternatives
- [spotify/XCLogParser](https://github.com/spotify/XCLogParser)
- [giginet/xcprofiler](https://github.com/giginet/xcprofiler)
