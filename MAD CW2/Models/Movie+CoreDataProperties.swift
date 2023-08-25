//
//  Movie+CoreDataProperties.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var coverimage: String?
    @NSManaged public var desc: String?
    @NSManaged public var genres: String?
    @NSManaged public var id: String?
    @NSManaged public var imdblink: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var releaseDate: Date?
    @NSManaged public var useroverallrating: Int32
    @NSManaged public var youtubelink: String?
    @NSManaged public var movieratingrelationship: NSOrderedSet?
    @NSManaged public var moviefavouriterelationship: Favourite?

}

// MARK: Generated accessors for movieratingrelationship
extension Movie {

    @objc(insertObject:inMovieratingrelationshipAtIndex:)
    @NSManaged public func insertIntoMovieratingrelationship(_ value: MovieRating, at idx: Int)

    @objc(removeObjectFromMovieratingrelationshipAtIndex:)
    @NSManaged public func removeFromMovieratingrelationship(at idx: Int)

    @objc(insertMovieratingrelationship:atIndexes:)
    @NSManaged public func insertIntoMovieratingrelationship(_ values: [MovieRating], at indexes: NSIndexSet)

    @objc(removeMovieratingrelationshipAtIndexes:)
    @NSManaged public func removeFromMovieratingrelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInMovieratingrelationshipAtIndex:withObject:)
    @NSManaged public func replaceMovieratingrelationship(at idx: Int, with value: MovieRating)

    @objc(replaceMovieratingrelationshipAtIndexes:withMovieratingrelationship:)
    @NSManaged public func replaceMovieratingrelationship(at indexes: NSIndexSet, with values: [MovieRating])

    @objc(addMovieratingrelationshipObject:)
    @NSManaged public func addToMovieratingrelationship(_ value: MovieRating)

    @objc(removeMovieratingrelationshipObject:)
    @NSManaged public func removeFromMovieratingrelationship(_ value: MovieRating)

    @objc(addMovieratingrelationship:)
    @NSManaged public func addToMovieratingrelationship(_ values: NSOrderedSet)

    @objc(removeMovieratingrelationship:)
    @NSManaged public func removeFromMovieratingrelationship(_ values: NSOrderedSet)

}

extension Movie : Identifiable {

}
