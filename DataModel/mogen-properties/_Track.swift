// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Track.swift instead.

import CoreData

// MARK: - Class methods
public extension Track {

public class var entityName: String {
return "Track"
}

public class func entity(managedObjectContext: NSManagedObjectContext) -> NSEntityDescription? {
return NSEntityDescription.entity(forEntityName: entityName, in: managedObjectContext)
}

@nonobjc public class func fetchRequest() -> NSFetchRequest<Track> {
return NSFetchRequest<Track>(entityName: entityName)
}

}

public extension Track {

public struct Attributes {
static let discNumber = "discNumber"
static let durationMilliseconds = "durationMilliseconds"
static let name = "name"
static let trackId = "trackId"
}

public struct Relationships {
static let album = "album"
}

// MARK: - Properties

@NSManaged public var discNumber: Int16

@NSManaged public var durationMilliseconds: Int64

@NSManaged public var name: String?

@NSManaged public var trackId: String?

// MARK: - Relationships

@NSManaged public var album: Album?

}
