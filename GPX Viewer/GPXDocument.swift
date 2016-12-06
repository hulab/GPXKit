//
//  GPXDocument.swift
//  GPX Viewer
//
//  Created by Maxime Epain on 12/10/2016.
//  Copyright © 2016 Hulab. All rights reserved.
//

import Cocoa
import GPXKit

class GPXDocument: NSDocument {
   
    var gpx: GPXRoot!

    override func makeWindowControllers() {
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        
        let windowController = storyboard.instantiateController(withIdentifier: "GPX") as! NSWindowController
        self.addWindowController(windowController)
        
        windowController.contentViewController?.representedObject = self.gpx
        
    }

    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != NULL, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override -fileWrapperOfType:error:, -writeToURL:ofType:error:, or -writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        guard let gpx = GPXParser.parseGPX(with: data) else {
            throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
        }
        self.gpx = gpx
    }
    
}
