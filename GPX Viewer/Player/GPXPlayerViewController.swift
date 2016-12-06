//
//  GPXPlayerViewController.swift
//  GPX Viewer
//
//  Created by Maxime Epain on 21/10/2016.
//  Copyright © 2016 Hulab. All rights reserved.
//

import Cocoa
import MapKit
import GPXKit

class GPXPlayerViewController: NSViewController,MKMapViewDelegate, GPXPlayerDelegate {
    
    var player : GPXPlayer!

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var playButon: NSButton!
    @IBOutlet weak var startLabel: NSTextField!
    @IBOutlet weak var endLabel: NSTextField!
    @IBOutlet weak var timeSlider: NSSlider!
    
    var waypoints = [GPXWaypoint]() //{
//        willSet {
//            // Remove points without timestamp
//            for point in waypoints {
//                if point.time == nil {
//                     mapView.removeAnnotation(point)
//                }
//            }
//        }
//        didSet {
//            // Directly add points without timestamp
//            for point in waypoints {
//                if point.time == nil {
//                    mapView.addAnnotation(point)
//                }
//            }
//        }
//    }
    
    var routepoints = [GPXRoutePoint]() //{
//        willSet {
//            // Remove points without timestamp
//            for point in routepoints {
//                if point.time == nil {
//                    mapView.remove(point)
//                }
//            }
//        }
//        didSet {
//            // Directly add points without timestamp
//            for point in routepoints {
//                if point.time == nil {
//                    mapView.add(point)
//                }
//            }
//        }
//    }
    
    var segment = GPXTrackSegment() {
//        willSet {
//            // Remove points without timestamp
//            for point in segment.trackpoints {
//                if point.time == nil {
//                    mapView.remove(point)
//                }
//            }
//        }
        didSet {
            // Directly add points without timestamp
//            for point in segment.trackpoints {
//                if point.time == nil {
//                    mapView.add(point)
//                }
//            }
            
            self.mapView.show(overlay: segment, animated: true)
            startsAt = segment.trackpoints.startTime()
            endsAt = segment.trackpoints.endTime()
            player?.time = startsAt // clean previous player
            
            var points = waypoints
            points.append(contentsOf: routepoints as [GPXWaypoint])
            points.append(contentsOf: segment.trackpoints as [GPXWaypoint])
            
            player = GPXPlayer(waypoints: points)
            player.delegate = self
            player.time = startsAt
        }
    }
    
    var isPlaying = false {
        didSet {
            
            if isPlaying {
                playButon.image = NSImage(named: "pause")
                player?.play()
            } else {
                playButon.image = NSImage(named: "play")
                player?.pause()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    var startsAt : Date! {
        didSet {
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            
            if let endsAt = endsAt {
                timeSlider.maxValue = endsAt.timeIntervalSince(startsAt)
            }
        }
    }
    
    var endsAt : Date! {
        didSet {
            let formatter = DateFormatter()
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.dateFormat = "HH:mm:ss"
            
            endLabel.stringValue = endsAt.timeIntervalSince(startsAt).string()
            
            if let endsAt = endsAt {
                timeSlider.maxValue = endsAt.timeIntervalSince(startsAt)
            }
        }
    }
    
    // MARK: Player control
    
    @IBAction func play(_ sender: NSButton) {
        isPlaying = !isPlaying
    }
    
    @IBAction func backward(_ sender: NSButton) {
        player?.backward()
    }
    
    @IBAction func forward(_ sender: NSButton) {
        player?.forward()
    }
    
    @IBAction func slide(_ sender: NSSlider) {
        let interval = sender.doubleValue as TimeInterval
        player?.time = Date(timeInterval: interval, since: startsAt)
        startLabel.stringValue = interval.string()
    }
    
    // MARK: GPXPlayerDelegate
    
    func player(player: GPXPlayer, didChange time: Date) {
        
        var t = time
        if t < startsAt || t > endsAt {
            t = min(startsAt, max(endsAt, time))
            
            player.time = t
            player.pause()
            isPlaying = false
            
        } else {
            let interval = t.timeIntervalSince(startsAt)
            
            timeSlider.setDoubleValue(interval, animated: true)
            startLabel.stringValue = interval.string()
        }
    }
    
    func player(player: GPXPlayer, show waypoint: GPXWaypoint) {
        
        if let trackpoint = waypoint as? GPXTrackPoint {
            mapView.add(trackpoint)
        } else if let routepoint = waypoint as? GPXRoutePoint {
            mapView.add(routepoint)
        } else {
            mapView.addAnnotation(waypoint)
        }
    }
    
    func player(player: GPXPlayer, hide waypoint: GPXWaypoint) {
        
        if let trackpoint = waypoint as? GPXTrackPoint {
            mapView.remove(trackpoint)
        } else if let routepoint = waypoint as? GPXRoutePoint {
            mapView.remove(routepoint)
        } else {
            mapView.removeAnnotation(waypoint)
        }
    }
    
    // MARK: MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let segment = overlay as? GPXTrackSegment {
            let renderer = GPXTrackSegmentRenderer(segment: segment)
            renderer.strokeColor = NSColor.gray
            renderer.lineWidth = 3
            return renderer
            
        } else if let trackpoint = overlay as? GPXTrackPoint {
            let renderer = GPXTrackPointRenderer(trackpoint: trackpoint)
            renderer.fillColor = NSColor.green
            return renderer
            
        } else if let routepoint = overlay as? GPXRoutePoint {
            let renderer = GPXRoutePointRenderer(routepoint: routepoint)
            renderer.fillColor = NSColor.blue
            return renderer
        } else if let polyline = overlay as? MKPolyline {
            let renderer = MKPolylineRenderer(polyline: polyline)
            renderer.strokeColor = NSColor.red
            renderer.lineWidth = 3
            return renderer
        }
        
        return MKOverlayRenderer(overlay: overlay)
    }
    
}

extension MKMapView {
    func show(overlay: MKOverlay, animated: Bool) {
        self.setVisibleMapRect(mapRectThatFits(overlay.boundingMapRect),
                               edgePadding: EdgeInsets(top: 44, left: 44, bottom: 44, right: 44),
                               animated: animated)
    }
}

class GPXPlayerSliderCell: NSSliderCell {
    
    override func drawBar(inside rect: NSRect, flipped: Bool) {
        let knobRect_ = knobRect(flipped: flipped)
        
        var leftRect = rect
        leftRect.size.width = knobRect_.origin.x + (knobRect_.size.width / 2)
        
        
        if let context = NSGraphicsContext.current()?.cgContext {
            context.saveGState()
            
            context.setFillColor(CGColor.clear)
            context.fill(rect)
            
            let path = NSBezierPath(roundedRect: rect, xRadius: rect.size.height / 2, yRadius: rect.size.height / 2)
            path.setClip()
            
            context.setFillColor(CGColor.white)
            context.fill(leftRect)
            
            context.restoreGState()
        }
    }
}

extension TimeInterval {
    
    func string() -> String {
        
        let interval = Int(self)
        let seconds = interval % 60
        let minutes = (interval / 60) % 60
        let hours = (interval / 3600)
        
        if hours > 0 {
            return String(format: "%i:%i:%02d", hours, minutes, seconds)
        }
        return String(format: "%i:%02d", minutes, seconds)
    }
}
