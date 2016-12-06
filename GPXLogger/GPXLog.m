// GPXLog.m
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

#import <GPXKit/GPXParser.h>
#import <GPXKit/GPXRoot.h>
#import <GPXKit/GPXMetadata.h>
#import <GPXKit/GPXTrack.h>
#import <GPXKit/GPXTrackSegment.h>
#import <GPXKit/GPXTrackPoint.h>
#import <GPXKit/GPXRoute.h>
#import <GPXKit/GPXRoutePoint.h>

#import "GPXLog.h"

@interface GPXLog : NSObject

@property (nonatomic, readonly) NSString *path;

@property (nonatomic, readonly) GPXRoot *gpx;

- (instancetype)initWithPath:(NSString *)path NS_DESIGNATED_INITIALIZER;

+ (GPXLog *)sharedLog;

+ (void)setSharedLog:(GPXLog *)log;

- (void)save;

@end

void GPXSetPath(NSString *path) {
    GPXLog *log = [[GPXLog alloc] initWithPath:path];
    [GPXLog setSharedLog:log];
}

NSString *GPXPath() {
    return [GPXLog sharedLog].path;
}

void GPXSetCreator(NSString *creator) {
    [GPXLog sharedLog].gpx.creator = creator;
}

void GPXSetVersion(NSString *version) {
    [GPXLog sharedLog].gpx.version = version;
}

void GPXSetMetadata(GPXMetadata *metadata) {
    [GPXLog sharedLog].gpx.metadata = metadata;
}

void GPXLogWaypoint(GPXWaypoint *waypoint) {
    [[GPXLog sharedLog].gpx addWaypoint:waypoint];
}

void GPXLogTrack(GPXTrack *track) {
    [[GPXLog sharedLog].gpx addTrack:track];
}

void GPXLogSegment(GPXTrackSegment *segment) {
    GPXRoot *gpx = [GPXLog sharedLog].gpx;
    
    GPXTrack *track = gpx.tracks.lastObject;
    if (!track) {
        track = [gpx newTrack];
    }
    [track addTracksegment:segment];
}

void GPXLogTrackpoint(GPXTrackPoint *trackpoint) {
    GPXRoot *gpx = [GPXLog sharedLog].gpx;
    
    GPXTrack *track = gpx.tracks.lastObject;
    if (!track) {
        track = [gpx newTrack];
    }
    
    GPXTrackSegment *segment = track.tracksegments.lastObject;
    if (!segment) {
        segment = [track newTrackSegment];
    }
    [segment addTrackpoint:trackpoint];
}

void GPXLogRoute(GPXRoute *route) {
    [[GPXLog sharedLog].gpx addRoute:route];
}

void GPXLogRoutepoint(GPXRoutePoint *routepoint) {
    GPXRoot *gpx = [GPXLog sharedLog].gpx;
    
    GPXRoute *route = gpx.routes.lastObject;
    if (!route) {
        route = [gpx newRoute];
    }
    [route addRoutepoint:routepoint];
}

void GPXSave() {
    [[GPXLog sharedLog] save];
}

@implementation GPXLog

static GPXLog *sharedLog = nil;

- (instancetype)init {
    NSString *directory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *path = [directory stringByAppendingPathComponent:@"log.gpx"];
    return [self initWithPath:path];
}

- (instancetype)initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        _path = path;
        _gpx = [GPXParser parseGPXAtPath:path];
        
        if (!_gpx) {
            _gpx = [[GPXRoot alloc] init];
        }
    }
    return self;
}

+ (GPXLog *)sharedLog {
    if (!sharedLog) {
        sharedLog = [[GPXLog alloc] init];
    }
    return sharedLog;
}

+ (void)setSharedLog:(GPXLog *)log {
    sharedLog = log;
}

- (void)save {
    NSError *error = nil;
    [self.gpx saveToPath:self.path error:&error];
    
    if (error) {
        NSLog(@"%@", error);
    }
}

@end
