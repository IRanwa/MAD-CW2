//
//  MovieRating+CoreDataProperties.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//
//

import Foundation
import CoreData


extension MovieRating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieRating> {
        return NSFetchRequest<MovieRating>(entityName: "MovieRating")
    }

    @NSManaged public var comment: String?
    @NSManaged public var id: String?
    @NSManaged public var movieid: String?
    @NSManaged public var rating: Int32
    @NSManaged public var userid: String?
    @NSManaged public var createddate: Date?
    @NSManaged public var movierelationship: Movie?
    @NSManaged public var userrelationship: User?

}

extension MovieRating : Identifiable {

}
