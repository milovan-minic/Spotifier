//
//  Artist+CoreDataProperties.swift
//  Spotifier
//
//  Created by iosakademija on 11/24/16.
//  Copyright © 2016 iOS akademija. All rights reserved.
//

import Foundation
import CoreData


extension Artist {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
        return NSFetchRequest<Artist>(entityName: "Artist");
    }

    @NSManaged public var artistId: String?
    @NSManaged public var followersCount: Int64
    @NSManaged public var ganeres: String?
    @NSManaged public var imageURL: String?
    @NSManaged public var name: String?
    @NSManaged public var popularity: Int64
    @NSManaged public var spotifyURL: String?
    @NSManaged public var albums: NSSet?

}

// MARK: Generated accessors for albums
extension Artist {

    @objc(addAlbumsObject:)
    @NSManaged public func addToAlbums(_ value: Album)

    @objc(removeAlbumsObject:)
    @NSManaged public func removeFromAlbums(_ value: Album)

    @objc(addAlbums:)
    @NSManaged public func addToAlbums(_ values: NSSet)

    @objc(removeAlbums:)
    @NSManaged public func removeFromAlbums(_ values: NSSet)

}
