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

#import <GPXKit/GPXKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 Sets the GPX log file path.

 @param path The GPX file path.
 */
FOUNDATION_EXPORT void GPXSetPath(NSString *path) NS_SWIFT_NAME(GPX.set(path:));

/**
 Gets the GPX log file path.
 
 @return The GPX file path.
 */
FOUNDATION_EXPORT NSString * _Nullable GPXPath(void) NS_SWIFT_NAME(GPX.path());

/**
 Sets the GPX file creator.

 @param creator The GPX file creator.
 */
FOUNDATION_EXPORT void GPXSetCreator(NSString *creator) NS_SWIFT_NAME(GPX.set(creator:));

/**
 Sets the GPX file version.

 @param version The GPX file version.
 */
FOUNDATION_EXPORT void GPXSetVersion(NSString *version) NS_SWIFT_NAME(GPX.set(version:));

/**
 Sets the GPX file metadata.

 @param metadata The GPX file metadata.
 */
FOUNDATION_EXPORT void GPXSetMetadata(GPXMetadata *metadata) NS_SWIFT_NAME(GPX.set(metadata:));

/**
 Logs the given waypoint.

 @param waypoint The waypoint to log.
 */
FOUNDATION_EXPORT void GPXLogWaypoint(GPXWaypoint *waypoint) NS_SWIFT_NAME(GPX.log(waypoint:));

/**
 Logs the given track.

 @param track The track to log.
 */
FOUNDATION_EXPORT void GPXLogTrack(GPXTrack *track) NS_SWIFT_NAME(GPX.log(track:));

/**
 Logs the given track segment. If no track has been added, a new one will be created.

 @param segment The track segment to log.
 */
FOUNDATION_EXPORT void GPXLogSegment(GPXTrackSegment *segment) NS_SWIFT_NAME(GPX.log(segment:));

/**
 Logs the given track point. If no track segment has been added, a new one will be created.

 @param trackpoint The track point to log.
 */
FOUNDATION_EXPORT void GPXLogTrackpoint(GPXTrackPoint *trackpoint) NS_SWIFT_NAME(GPX.log(trackpoint:));

/**
 Logs the given route.

 @param route The route to log.
 */
FOUNDATION_EXPORT void GPXLogRoute(GPXRoute *route) NS_SWIFT_NAME(GPX.log(route:));

/**
 Logs the given route point. If no route has been added, a new one will be created.

 @param routepoint The route point to log.
 */
FOUNDATION_EXPORT void GPXLogRoutepoint(GPXRoutePoint *routepoint) NS_SWIFT_NAME(GPX.log(routepoint:));

/**
 Saves the GPX log to disk.
 */
FOUNDATION_EXPORT void GPXSave(void) NS_SWIFT_NAME(GPX.save());

/**
 Empty class for swift mapping.
 */
@interface GPX

@end

NS_ASSUME_NONNULL_END
