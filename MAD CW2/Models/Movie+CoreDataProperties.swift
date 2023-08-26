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
    @NSManaged public var moviefavouriterelationship: NSOrderedSet?
    @NSManaged public var movieratingrelationship: NSOrderedSet?

}

// MARK: Generated accessors for moviefavouriterelationship
extension Movie {

    @objc(insertObject:inMoviefavouriterelationshipAtIndex:)
    @NSManaged public func insertIntoMoviefavouriterelationship(_ value: Favourite, at idx: Int)

    @objc(removeObjectFromMoviefavouriterelationshipAtIndex:)
    @NSManaged public func removeFromMoviefavouriterelationship(at idx: Int)

    @objc(insertMoviefavouriterelationship:atIndexes:)
    @NSManaged public func insertIntoMoviefavouriterelationship(_ values: [Favourite], at indexes: NSIndexSet)

    @objc(removeMoviefavouriterelationshipAtIndexes:)
    @NSManaged public func removeFromMoviefavouriterelationship(at indexes: NSIndexSet)

    @objc(replaceObjectInMoviefavouriterelationshipAtIndex:withObject:)
    @NSManaged public func replaceMoviefavouriterelationship(at idx: Int, with value: Favourite)

    @objc(replaceMoviefavouriterelationshipAtIndexes:withMoviefavouriterelationship:)
    @NSManaged public func replaceMoviefavouriterelationship(at indexes: NSIndexSet, with values: [Favourite])

    @objc(addMoviefavouriterelationshipObject:)
    @NSManaged public func addToMoviefavouriterelationship(_ value: Favourite)

    @objc(removeMoviefavouriterelationshipObject:)
    @NSManaged public func removeFromMoviefavouriterelationship(_ value: Favourite)

    @objc(addMoviefavouriterelationship:)
    @NSManaged public func addToMoviefavouriterelationship(_ values: NSOrderedSet)

    @objc(removeMoviefavouriterelationship:)
    @NSManaged public func removeFromMoviefavouriterelationship(_ values: NSOrderedSet)

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
