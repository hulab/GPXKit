# GPXKit

[![CI Status](http://img.shields.io/travis/hulab/GPXKit.svg?style=flat)](https://travis-ci.org/hulab/GPXKit)
[![Version](https://img.shields.io/cocoapods/v/GPXKit.svg?style=flat)](http://cocoapods.org/pods/GPXKit)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/GPXKit.svg?style=flat)](http://cocoapods.org/pods/GPXKit)
[![Platform](https://img.shields.io/cocoapods/p/GPXKit.svg?style=flat)](http://cocoapods.org/pods/GPXKit)

This project provide a iOS & macOS framework for parsing/generating GPX files.
This Framework parses the GPX from a URL or Strings and create Objective-C Instances of GPX structure. 

## Installation

GPXKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'GPXKit', :git => 'https://github.com/hulab/GPX.git'
```

## Usage

To parse a GPX file, simply call the parse method :

```objective-c
GPXRoot *root = [GPXParser parseGPXWithString:gpx];
```

You can also generate the GPX :

```objective-c
GPXRoot *root = [GPXRoot rootWithCreator:@"Sample Application"];

GPXWaypoint *waypoint = [root newWaypointWithLatitude:35.658609f longitude:139.745447f];
waypoint.name = @"Tokyo Tower";
waypoint.comment = @"The old TV tower in Tokyo.";

GPXTrack *track = [root newTrack];
track.name = @"My New Track";

[track newTrackpointWithLatitude:35.658609f longitude:139.745447f];
[track newTrackpointWithLatitude:35.758609f longitude:139.745447f];
[track newTrackpointWithLatitude:35.828609f longitude:139.745447f];
```

##_Note_
_GPXKit is based on [FLCLjp/iOS-GPX-Framework](https://github.com/FLCLjp/iOS-GPX-Framework)._

## License
 
GPXKit is available under the MIT license. See the LICENSE file for more info.
