// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Artist.swift instead.

import CoreData

// MARK: - Class methods
public extension Artist {

public class var entityName: String {
return "Artist"
}

public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
}

@nonobjc public class func fetchRequest() -> NSFetchRequest<Artist> {
return NSFetchRequest<Artist>(entityName: entityName)
}

}

public extension Artist {

public struct Attributes {
static let artistId = "artistId"
static let followersCount = "followersCount"
static let ganeres = "ganeres"
static let imageURL = "imageURL"
static let name = "name"
static let popularity = "popularity"
static let spotifyURL = "spotifyURL"
}

public struct Relationships {
static let albums = "albums"
}

// MARK: - Properties

@NSManaged public var artistId: String?

@NSManaged public var followersCount: Int64 // Optional scalars not supported

@NSManaged public var ganeres: String?

@NSManaged public var imageURL: String?

@NSManaged public var name: String?

@NSManaged public var popularity: Int64 // Optional scalars not supported

@NSManaged public var spotifyURL: String?

// MARK: - Relationships

@NSManaged public var albums: Set<Album>?

}
