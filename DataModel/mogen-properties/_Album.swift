// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Album.swift instead.

import CoreData

// MARK: - Class methods
public extension Album {

public class var entityName: String {
return "Album"
}

public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
}

@nonobjc public class func fetchRequest() -> NSFetchRequest<Album> {
return NSFetchRequest<Album>(entityName: entityName)
}

}

public extension Album {

public struct Attributes {
static let name = "name"
}

public struct Relationships {
static let artist = "artist"
static let tracks = "tracks"
}

// MARK: - Properties

@NSManaged public var name: String?

// MARK: - Relationships

@NSManaged public var artist: Artist?

@NSManaged public var tracks: Set<Track>?

}
