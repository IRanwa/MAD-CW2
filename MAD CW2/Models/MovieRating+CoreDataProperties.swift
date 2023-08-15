//
//  MovieRating+CoreDataProperties.swift
//  MAD CW2
//
//  Created by user235597 on 8/16/23.
//
//

import Foundation
import CoreData


extension MovieRating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieRating> {
        return NSFetchRequest<MovieRating>(entityName: "MovieRating")
    }

    @NSManaged public var comment: String?
    @NSManaged public var id: Int64
    @NSManaged public var movieid: Int64
    @NSManaged public var rating: Double
    @NSManaged public var userid: Int64
    @NSManaged public var movierelationship: Movie?
    @NSManaged public var userrelationship: User?

}

extension MovieRating : Identifiable {

}
