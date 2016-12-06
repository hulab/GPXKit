//
//  GPXMapKit.swift
//  GPX Viewer
//
//  Created by Maxime Epain on 11/10/2016.
//  Copyright © 2016 Hulab. All rights reserved.
//

import MapKit
import GPXKit

extension GPXWaypoint: MKAnnotation {
    
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(CLLocationDegrees(latitude), CLLocationDegrees(longitude))
    }
    
    public var title: String? {
        return name
    }
    
    public var subtitle: String? {
        return desc
    }
    
}

extension GPXTrackPoint: MKOverlay {
    
    public var boundingMapRect: MKMapRect {
        let region = MKCoordinateRegionMakeWithDistance(self.coordinate, 10, 10)
        
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))
        
        let a = MKMapPointForCoordinate(topLeft)
        let b = MKMapPointForCoordinate(bottomRight)
        
        return MKMapRect(origin: MKMapPoint(x:min(a.x, b.x), y:min(a.y, b.y)),
                         size: MKMapSize(width: abs(a.x - b.x), height: abs(a.y - b.y)))
    }
    
}

class GPXTrackPointRenderer: MKOverlayRenderer {
    
    let trackpoint: GPXTrackPoint!
    
    var fillColor = NSColor.red
    
    init(trackpoint: GPXTrackPoint) {
        self.trackpoint = trackpoint
        super.init(overlay: trackpoint)
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let bounds = rect(for: trackpoint.boundingMapRect)
        
        context.setFillColor(fillColor.cgColor)
        context.fillEllipse(in: bounds);
    }
    
}

extension GPXTrackSegment: MKOverlay {
    
    var polyline: MKPolyline {
        var points = [CLLocationCoordinate2D]()
        
        for point in trackpoints {
            points += [CLLocationCoordinate2DMake(CLLocationDegrees(point.latitude), CLLocationDegrees(point.longitude))]
        }
        
        return MKPolyline(coordinates: points, count: points.count)
    }
    
    public var coordinate: CLLocationCoordinate2D {
        return polyline.coordinate
    }
    
    public var boundingMapRect: MKMapRect {
        return polyline.boundingMapRect
    }
    
}

class GPXTrackSegmentRenderer: MKPolylineRenderer {
    
    override init(overlay: MKOverlay) {
        super.init(overlay: overlay)
    }
    
    init(segment: GPXTrackSegment) {
        super.init(polyline: segment.polyline)
    }
}

extension GPXRoutePoint: MKOverlay {
    
    public var boundingMapRect: MKMapRect {
        let region = MKCoordinateRegionMakeWithDistance(self.coordinate, 10, 10)
        
        let topLeft = CLLocationCoordinate2D(latitude: region.center.latitude + (region.span.latitudeDelta/2), longitude: region.center.longitude - (region.span.longitudeDelta/2))
        let bottomRight = CLLocationCoordinate2D(latitude: region.center.latitude - (region.span.latitudeDelta/2), longitude: region.center.longitude + (region.span.longitudeDelta/2))
        
        let a = MKMapPointForCoordinate(topLeft)
        let b = MKMapPointForCoordinate(bottomRight)
        
        return MKMapRect(origin: MKMapPoint(x:min(a.x, b.x), y:min(a.y, b.y)),
                         size: MKMapSize(width: abs(a.x - b.x), height: abs(a.y - b.y)))
    }
    
}

class GPXRoutePointRenderer: MKOverlayRenderer {
    
    let routepoint: GPXRoutePoint!
    
    var fillColor = NSColor.blue
    
    init(routepoint: GPXRoutePoint) {
        self.routepoint = routepoint
        super.init(overlay: routepoint)
    }
    
    override func draw(_ mapRect: MKMapRect, zoomScale: MKZoomScale, in context: CGContext) {
        let bounds = rect(for: routepoint.boundingMapRect)
        
        context.setFillColor(fillColor.cgColor)
        context.fillEllipse(in: bounds);
    }
    
}
