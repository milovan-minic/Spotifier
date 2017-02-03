//
//  Track+CoreDataProperties.swift
//  Spotifier
//
//  Created by iosakademija on 12/2/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track");
    }

    @NSManaged public var name: String
    @NSManaged public var trackId: String
    @NSManaged public var discNumber: Int16
    @NSManaged public var durationMilliseconds: Int64
    @NSManaged public var album: Album?

}
