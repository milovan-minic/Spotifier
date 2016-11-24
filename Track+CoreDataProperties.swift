//
//  Track+CoreDataProperties.swift
//  Spotifier
//
//  Created by iosakademija on 11/24/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation
import CoreData


extension Track {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
        return NSFetchRequest<Track>(entityName: "Track");
    }

    @NSManaged public var name: String?

}
