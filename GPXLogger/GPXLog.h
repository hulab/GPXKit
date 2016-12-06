// GPXLog.h
//
// Created by Maxime Epain on 05/12/2016.
// Copyright © 2016 Hulab. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GPXMetadata;
@class GPXWaypoint;
@class GPXTrack;
@class GPXTrackSegment;
@class GPXTrackPoint;
@class GPXRoute;
@class GPXRoutePoint;

extern void GPXSetPath(NSString *path) NS_SWIFT_NAME(GPX.set(path:));

extern NSString * _Nullable GPXPath(void) NS_SWIFT_NAME(GPX.path());

extern void GPXSetCreator(NSString *creator) NS_SWIFT_NAME(GPX.set(creator:));

extern void GPXSetVersion(NSString *version) NS_SWIFT_NAME(GPX.set(version:));

extern void GPXSetMetadata(GPXMetadata *metadata) NS_SWIFT_NAME(GPX.set(metadata:));

extern void GPXLogWaypoint(GPXWaypoint *waypoint) NS_SWIFT_NAME(GPX.log(waypoint:));

extern void GPXLogTrack(GPXTrack *track) NS_SWIFT_NAME(GPX.log(track:));

extern void GPXLogSegment(GPXTrackSegment *segment) NS_SWIFT_NAME(GPX.log(segment:));

extern void GPXLogTrackpoint(GPXTrackPoint *trackpoint) NS_SWIFT_NAME(GPX.log(trackpoint:));

extern void GPXLogRoute(GPXRoute *route) NS_SWIFT_NAME(GPX.log(route:));

extern void GPXLogRoutepoint(GPXRoutePoint *routepoint) NS_SWIFT_NAME(GPX.log(routepoint:));

extern void GPXSave(void) NS_SWIFT_NAME(GPX.save());

NS_ASSUME_NONNULL_END
