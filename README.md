# BBCodeString

[![CI Status](http://img.shields.io/travis/mrataj/BBCodeString.svg?style=flat)](https://travis-ci.org/mrataj/BBCodeString)
[![Version](https://img.shields.io/cocoapods/v/BBCodeString.svg?style=flat)](http://cocoapods.org/pods/BBCodeString)
[![License](https://img.shields.io/cocoapods/l/BBCodeString.svg?style=flat)](http://cocoapods.org/pods/BBCodeString)
[![Platform](https://img.shields.io/cocoapods/p/BBCodeString.svg?style=flat)](http://cocoapods.org/pods/BBCodeString)

## Usage

BBCodeString is a simple library which enables you to create NSAttributedString object from bb code string.

Example of use:

```objectivec
NSString *bbCode = @"[user id=\"42\"]Mary Jones[/user] sent file [file id=\"23\"]Report.pdf[/file].";

BBCodeString *bbCodeString = [[BBCodeString alloc] initWithBBCode:bbCode andLayoutProvider:self];
NSAttributedString *myString = bbCodeString.attributedString;
You can simply set visual attributes for each BB code element by setting layout provider.
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

BBCodeString is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "BBCodeString"
```

## Author

Miha Rataj, rataj.miha@gmail.com

## License

BBCodeString is available under the MIT license. See the LICENSE file for more info.
