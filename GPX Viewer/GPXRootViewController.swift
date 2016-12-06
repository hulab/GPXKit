//
//  GPXRootViewController.swift
//  GPX Viewer
//
//  Created by Maxime Epain on 21/10/2016.
//  Copyright © 2016 Hulab. All rights reserved.
//

import Cocoa
import GPXKit

protocol GPXRootViewControllerDelegate {
    func rootViewController(rootViewController: GPXRootViewController, didSelect segment: GPXTrackSegment)
}

class GPXRootViewController: NSViewController, NSOutlineViewDataSource, NSOutlineViewDelegate {
    
    @IBOutlet weak var outlineView: NSOutlineView!
    
    var gpx : GPXRoot! {
        didSet {
            tracks = gpx.tracks
            routes = gpx.routes
            outlineView.reloadData()
        }
    }
    
    var tracks = [GPXTrack]()
    var routes = [GPXRoute]()
    
    var delegate : GPXRootViewControllerDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    // MARK: NSOutlineViewDataSource
    
    func outlineView(_ outlineView: NSOutlineView, numberOfChildrenOfItem item: Any?) -> Int {
        
        if let routes = item as? [GPXRoute] {
            return routes.count
        }
        if let route = item as? GPXRoute {
            return route.routepoints.count
        }
        if let tracks = item as? [GPXTrack] {
            return tracks.count
        }
        if let track = item as? GPXTrack {
            return track.tracksegments.count
        }
        return 2
    }
    
    func outlineView(_ outlineView: NSOutlineView, child index: Int, ofItem item: Any?) -> Any {
        
        if let routes = item as? [GPXRoute] {
            return routes[index]
        }
        if let route = item as? GPXRoute {
            return route.routepoints[index]
        }
        if let tracks = item as? [GPXTrack] {
            return tracks[index]
        }
        if let track = item as? GPXTrack {
            return track.tracksegments[index]
        }
        if index == 0 {
            return tracks
        }
        if index == 1 {
            return routes
        }
        return gpx
    }
    
    func outlineView(_ outlineView: NSOutlineView, isItemExpandable item: Any) -> Bool {
        
        if let routes = item as? [GPXRoute] {
            return routes.count > 0
        }
        if let route = item as? GPXRoute {
            return route.routepoints.count > 0
        }
        if let tracks = item as? [GPXTrack] {
            return tracks.count > 0
        }
        if let track = item as? GPXTrack {
            return track.tracksegments.count > 0
        }
        if item is GPXRoot {
            return true
        }
        return false
    }
    
    // MARK: NSOutlineViewDelegate
    
    func outlineView(_ outlineView: NSOutlineView, viewFor tableColumn: NSTableColumn?, item: Any) -> NSView? {
        let view = outlineView.make(withIdentifier: "Cell", owner: self) as? NSTableCellView
        
        if let gpx = item as? GPXRoot, let textField = view?.textField {
            let name = gpx.metadata?.name ?? "GPX File"
            textField.stringValue = name
            textField.sizeToFit()
            return view
        }
        if item is [GPXRoute], let textField = view?.textField {
            textField.stringValue = "Routes"
            textField.sizeToFit()
            return view
        }
        if item is [GPXTrack], let textField = view?.textField {
            textField.stringValue = "Tracks"
            textField.sizeToFit()
            return view
        }
        
        if let track = item as? GPXTrack, let textField = view?.textField {
            let name = track.name ?? "Track"
            textField.stringValue = name
            textField.sizeToFit()
            return view
        }
        if let route = item as? GPXRoute, let textField = view?.textField {
            let name = route.name ?? "Route"
            textField.stringValue = name
            textField.sizeToFit()
            return view
        }
        if let routepoint = item as? GPXRoutePoint, let textField = view?.textField {
            let name = routepoint.name ?? "Point"
            textField.stringValue = name
            textField.sizeToFit()
            return view
        }
        if let segment = item as? GPXTrackSegment, let textField = view?.textField  {
            textField.stringValue = "\(segment.trackpoints.count) points"
            textField.sizeToFit()
        }
        return view
    }
    
    func outlineViewSelectionDidChange(_ notification: Notification) {
        guard let outlineView = notification.object as? NSOutlineView else {
            return
        }

        if let segment = outlineView.item(atRow: outlineView.selectedRow) as? GPXTrackSegment {
            delegate?.rootViewController(rootViewController: self, didSelect: segment)
        }
    }
    
}
