// GPX+MapKit.m
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
#import "GPX+MapKit.h"

@implementation GPXWaypoint (MapKit)

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return self.desc;
}

- (CLLocationCoordinate2D)coordinate {
    return CLLocationCoordinate2DMake(self.latitude, self.longitude);
}

@end

@implementation GPXTrackPoint (MapKit)

- (MKMapRect)boundingMapRect {
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(self.coordinate, 10, 10);
    
    CLLocationCoordinate2D topLeft = CLLocationCoordinate2DMake(region.center.latitude + (region.span.latitudeDelta/2), region.center.longitude - (region.span.longitudeDelta/2));
    CLLocationCoordinate2D bottomRight = CLLocationCoordinate2DMake(region.center.latitude - (region.span.latitudeDelta/2), region.center.longitude + (region.span.longitudeDelta/2));
    
    MKMapPoint a = MKMapPointForCoordinate(topLeft);
    MKMapPoint b = MKMapPointForCoordinate(bottomRight);
    
    return MKMapRectMake(MIN(a.x, b.x), MIN(a.y, b.y), ABS(a.x - b.x), ABS(a.y - b.y));
}

@end

@implementation GPXTrackPointRenderer

- (instancetype)initWithPoint:(GPXTrackPoint *)point {
    self = [super initWithOverlay:point];
    if (self) {
        _trackPoint = point;
    }
    return self;
}

- (void)drawMapRect:(MKMapRect)mapRect zoomScale:(MKZoomScale)zoomScale inContext:(CGContextRef)context {
    CGRect bounds = [self rectForMapRect:self.trackPoint.boundingMapRect];
    
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextFillEllipseInRect(context, bounds);
}

@end

@implementation GPXTrackSegment (MapKit)

- (MKPolyline *)polyline {
    
    CLLocationCoordinate2D *points = (CLLocationCoordinate2D *)malloc(self.trackpoints.count * sizeof(CLLocationCoordinate2D));
    
    for (int i = 0; i < self.trackpoints.count; ++i) {
        points[i] = self.trackpoints[i].coordinate;
    }

    MKPolyline *polyline = [MKPolyline polylineWithCoordinates:points count:self.trackpoints.count];
    free(points);
    return polyline;
}

- (CLLocationCoordinate2D)coordinate {
    return self.polyline.coordinate;
}

- (MKMapRect)boundingMapRect {
    return self.polyline.boundingMapRect;
}

@end

@implementation GPXTrackSegmentRenderer

- (instancetype)initWithSegment:(GPXTrackSegment *)segment {
    self = [super initWithPolyline:segment.polyline];
    if (self) {
    }
    return self;
}

@end
