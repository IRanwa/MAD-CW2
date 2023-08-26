//
//  User+CoreDataProperties.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstname: String?
    @NSManaged public var id: String?
    @NSManaged public var lastname: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var title: String?
    @NSManaged public var usertype: String?
    @NSManaged public var ratinguserrelationship: NSOrderedSet?
    @NSManaged public var favouriterelationship: NSOrderedSet?

}

// MARK: Generated accessors for ratinguserrelationship
extension User {

    @objc(insertObject:inRatinguserrelationshipAtIndex:)
    @NSManaged public func insertIntoRatinguserrelationship(_ value: MovieRating, at idx: Int)

    @objc(removeObjectFromRatinguserrelationshipAtIndex:)
    @NSManaged public func removeFromRatinguserrelationship(at idx: Int)

    @objc(insertRatinguserrelationship:atIndexes:)
    @NSManaged public func insertIntoRatinguserrelationship(_ values: [MovieRating], at indexes: NSIndexSet)

    @objc(removeRatinguserrelationshipAtIndexes:)
    @NSManaged public func removeFromRatinguserrelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInRatinguserrelationshipAtIndex:withObject:)
    @NSManaged public func replaceRatinguserrelationship(at idx: Int, with value: MovieRating)

    @objc(replaceRatinguserrelationshipAtIndexes:withRatinguserrelationship:)
    @NSManaged public func replaceRatinguserrelationship(at indexes: NSIndexSet, with values: [MovieRating])

    @objc(addRatinguserrelationshipObject:)
    @NSManaged public func addToRatinguserrelationship(_ value: MovieRating)

    @objc(removeRatinguserrelationshipObject:)
    @NSManaged public func removeFromRatinguserrelationship(_ value: MovieRating)

    @objc(addRatinguserrelationship:)
    @NSManaged public func addToRatinguserrelationship(_ values: NSOrderedSet)

    @objc(removeRatinguserrelationship:)
    @NSManaged public func removeFromRatinguserrelationship(_ values: NSOrderedSet)

}

// MARK: Generated accessors for favouriterelationship
extension User {

    @objc(insertObject:inFavouriterelationshipAtIndex:)
    @NSManaged public func insertIntoFavouriterelationship(_ value: Favourite, at idx: Int)

    @objc(removeObjectFromFavouriterelationshipAtIndex:)
    @NSManaged public func removeFromFavouriterelationship(at idx: Int)

    @objc(insertFavouriterelationship:atIndexes:)
    @NSManaged public func insertIntoFavouriterelationship(_ values: [Favourite], at indexes: NSIndexSet)

    @objc(removeFavouriterelationshipAtIndexes:)
    @NSManaged public func removeFromFavouriterelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInFavouriterelationshipAtIndex:withObject:)
    @NSManaged public func replaceFavouriterelationship(at idx: Int, with value: Favourite)

    @objc(replaceFavouriterelationshipAtIndexes:withFavouriterelationship:)
    @NSManaged public func replaceFavouriterelationship(at indexes: NSIndexSet, with values: [Favourite])

    @objc(addFavouriterelationshipObject:)
    @NSManaged public func addToFavouriterelationship(_ value: Favourite)

    @objc(removeFavouriterelationshipObject:)
    @NSManaged public func removeFromFavouriterelationship(_ value: Favourite)

    @objc(addFavouriterelationship:)
    @NSManaged public func addToFavouriterelationship(_ values: NSOrderedSet)

    @objc(removeFavouriterelationship:)
    @NSManaged public func removeFromFavouriterelationship(_ values: NSOrderedSet)

}

extension User : Identifiable {

}
