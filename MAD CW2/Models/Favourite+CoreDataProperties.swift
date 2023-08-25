//
//  Favourite+CoreDataProperties.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var id: String?
    @NSManaged public var movieId: String?
    @NSManaged public var userId: String?
    @NSManaged public var movierelatioship: NSOrderedSet?

}

// MARK: Generated accessors for movierelatioship
extension Favourite {

    @objc(insertObject:inMovierelatioshipAtIndex:)
    @NSManaged public func insertIntoMovierelatioship(_ value: Movie, at idx: Int)

    @objc(removeObjectFromMovierelatioshipAtIndex:)
    @NSManaged public func removeFromMovierelatioship(at idx: Int)

    @objc(insertMovierelatioship:atIndexes:)
    @NSManaged public func insertIntoMovierelatioship(_ values: [Movie], at indexes: NSIndexSet)

    @objc(removeMovierelatioshipAtIndexes:)
    @NSManaged public func removeFromMovierelatioship(at indexes: NSIndexSet)

    @objc(replaceObjectInMovierelatioshipAtIndex:withObject:)
    @NSManaged public func replaceMovierelatioship(at idx: Int, with value: Movie)

    @objc(replaceMovierelatioshipAtIndexes:withMovierelatioship:)
    @NSManaged public func replaceMovierelatioship(at indexes: NSIndexSet, with values: [Movie])

    @objc(addMovierelatioshipObject:)
    @NSManaged public func addToMovierelatioship(_ value: Movie)

    @objc(removeMovierelatioshipObject:)
    @NSManaged public func removeFromMovierelatioship(_ value: Movie)

    @objc(addMovierelatioship:)
    @NSManaged public func addToMovierelatioship(_ values: NSOrderedSet)

    @objc(removeMovierelatioship:)
    @NSManaged public func removeFromMovierelatioship(_ values: NSOrderedSet)

}

extension Favourite : Identifiable {

}
