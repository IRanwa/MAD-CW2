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

extension User : Identifiable {

}
