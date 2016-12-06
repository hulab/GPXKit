GPXKit
============================

This project provide a iOS & macOS framework for parsing/generating GPX files.
This Framework parses the GPX from a URL or Strings and create Objective-C Instances of GPX structure. 

How to use framework in my project?
---------------------------------

Drag the framework file into the project's Frameworks group, and import the header file.

	#import <GPXKit/GPXKit.h>


To parsing the GPX file, simply call the parse method :

	GPXRoot *root = [GPXParser parseGPXWithString:gpx];


You can generate the GPX :

    GPXRoot *root = [GPXRoot rootWithCreator:@"Sample Application"];
    
    GPXWaypoint *waypoint = [root newWaypointWithLatitude:35.658609f longitude:139.745447f];
    waypoint.name = @"Tokyo Tower";
    waypoint.comment = @"The old TV tower in Tokyo.";
    
    GPXTrack *track = [root newTrack];
    track.name = @"My New Track";
    
    [track newTrackpointWithLatitude:35.658609f longitude:139.745447f];
    [track newTrackpointWithLatitude:35.758609f longitude:139.745447f];
    [track newTrackpointWithLatitude:35.828609f longitude:139.745447f];


Acknowledgment
---------------------------------

[TBXML](http://tbxml.co.uk/TBXML/TBXML_Free.html) Copyright (c) 2009 Tom Bradley
