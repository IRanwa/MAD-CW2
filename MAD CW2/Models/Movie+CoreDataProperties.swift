//
//  Movie+CoreDataProperties.swift
//  MAD CW2
//
//  Created by user235597 on 8/16/23.
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
    @NSManaged public var id: String
    @NSManaged public var imdblink: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: Double
    @NSManaged public var useroverallrating: Double
    @NSManaged public var youtubelink: String?
    @NSManaged public var releaseDate: Date?
    @NSManaged public var genres: String?
    @NSManaged public var movieratingrelationship: MovieRating?

}

extension Movie : Identifiable {

}
