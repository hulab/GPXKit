//
//  GPXPlayer.swift
//  GPX Viewer
//
//  Created by Maxime Epain on 12/10/2016.
//  Copyright © 2016 Hulab. All rights reserved.
//

import Foundation
import MapKit
import GPXKit

protocol GPXPlayerDelegate {
    
    func player(player: GPXPlayer, didChange time: Date)
    
    func player(player: GPXPlayer, show waypoint: GPXWaypoint)
    func player(player: GPXPlayer, hide waypoint: GPXWaypoint)
}

class GPXPlayer {
    
    var delegate: GPXPlayerDelegate!
    
    init(waypoints: [GPXWaypoint]) {
        self.waypoints = waypoints
    }
    
    // MARK: Player data
    
    private(set) var waypoints = [GPXWaypoint]()
    
    // MARK: Player control
    
    var time = Date.distantPast {
        didSet {
            
            if oldValue <= time {
                show(from: oldValue, to: time)
            } else {
                hide(from: time, to: oldValue)
            }
        }
    }
    
    private var timer: Timer!
    
    func play() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: TimeInterval(1), repeats: true)
        RunLoop.current.add(timer, forMode: RunLoopMode.commonModes)
    }
    
    func pause() {
        timer?.invalidate()
    }
    
    func forward() {
        if let timer = timer, timer.isValid {
            timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: TimeInterval(10), repeats: true)
            RunLoop.current.add(self.timer, forMode: RunLoopMode.commonModes)
        } else {
            time += 10
            delegate?.player(player: self, didChange: time)
        }
    }
    
    func backward() {
        if let timer = timer, timer.isValid {
            timer.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: TimeInterval(-10), repeats: true)
            RunLoop.current.add(self.timer, forMode: RunLoopMode.commonModes)
        } else {
            time -= 10
            delegate?.player(player: self, didChange: time)
        }
    }
    
    @objc private func update() {
        if timer!.isValid {
            time += timer.userInfo as! TimeInterval
            delegate?.player(player: self, didChange: time)
        }
    }
    
    // MARK: Player display
    
    private func show(from start: Date, to end: Date) {
        
        for waypoint in waypoints {
            
            let time = waypoint.time ?? Date.distantPast
            if time >= start, time <= end {
                delegate?.player(player: self, show: waypoint)
            }
        }
    }
    
    private func hide(from start: Date,to end: Date) {
        
        for waypoint in waypoints {
            
            let time = waypoint.time ?? Date.distantPast
            if time > start, time <= end {
                delegate?.player(player: self, hide: waypoint)
            }
        }
    }
    
}

extension Array where Element:GPXWaypoint  {
    
    private func sortedByTime() -> [GPXWaypoint] {
        let points = filter { (point) -> Bool in
            guard point.time != nil else {
                return false
            }
            return true
        }
        
        return points.sorted { (p1, p2) -> Bool in
            return p1.time! < p2.time!
        }
    }
    
    func startTime() -> Date {
        guard let time = sortedByTime().first?.time else {
            return Date.distantPast
        }
        return time
    }

    func endTime() -> Date {
        guard let time = sortedByTime().last?.time else {
            return Date.distantPast
        }
        return time
    }
    
}
