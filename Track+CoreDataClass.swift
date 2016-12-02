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
    
    convenience init?(json: [String: Any], in context: NSManagedObjectContext) {
        self.init(context: context)
        
        self.name = (json["name"] as? String) ?? ""
        if let discNum = json["disc_number"] as? Int16 {
            self.discNumber = discNum
        }
    }
}
