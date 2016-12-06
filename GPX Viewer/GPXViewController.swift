//
//  GPXViewController.swift
//  GPX Viewer
//
//  Created by Maxime Epain on 21/10/2016.
//  Copyright © 2016 Hulab. All rights reserved.
//

import Cocoa
import GPXKit

class GPXViewController: NSSplitViewController, GPXRootViewControllerDelegate {
    
    var rootViewController : GPXRootViewController!
    var playerViewController : GPXPlayerViewController!

    @IBOutlet weak var rootItem: NSSplitViewItem!
    @IBOutlet weak var playerItem: NSSplitViewItem!
    
    override var representedObject: Any? {
        didSet {
            
            if let gpx = self.representedObject as? GPXRoot {
                rootViewController.gpx = gpx
                
                add(waypoints: gpx.waypoints)
                add(tracks: gpx.tracks)
                add(routes: gpx.routes)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootViewController = rootItem.viewController as? GPXRootViewController
        rootViewController.delegate = self;
        
        playerViewController = playerItem.viewController as? GPXPlayerViewController
    }
    
    func add(waypoints: [GPXWaypoint]) {
        playerViewController.waypoints = waypoints
    }
    
    func add(tracks: [GPXTrack]) {
        for track in tracks {
            add(segments: track.tracksegments)
        }
    }
    
    func add(segments: [GPXTrackSegment]) {
        playerViewController.mapView.addOverlays(segments)
    }
    
    func add(routes: [GPXRoute]) {
        var points = [GPXRoutePoint]()
        for route in routes {
            points += route.routepoints
        }
        playerViewController.routepoints = points
    }
    
    
    // MARK: GPXRootViewControllerDelegate
    
    func rootViewController(rootViewController: GPXRootViewController, didSelect segment: GPXTrackSegment) {
        playerViewController.segment = segment
        playerViewController.mapView.show(overlay: segment, animated: true)
    }
}
