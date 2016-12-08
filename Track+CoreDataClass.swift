//
//  Track+CoreDataClass.swift
//  Spotifier
//
//  Created by iosakademija on 11/24/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation
import CoreData

@objc(Track)
public class Track: NSManagedObject {
    
    enum Attributes: String {
        case name
    }

}

extension Track {
    
    convenience init(json: [String: Any], in context: NSManagedObjectContext) throws {
        self.init(context: context)
        
        guard let trackId = json["id"] as? String else { throw DataImportError.typeMismatch(expected: String.self, actual: type(of: json["id"]), key: "id") }
        guard let name = json["name"] as? String else { throw DataImportError.typeMismatch(expected: String.self, actual: type(of: json["name"]), key: "name") }
        
        self.trackId = trackId
        self.name = name
        if let discNum = json["disc_number"] as? Int16 {
            self.discNumber = discNum
        }
        
        if let durationMilliseconds = json["duration_ms"] as? Int64 {
            self.durationMilliseconds = durationMilliseconds
        }
        
    }
}
