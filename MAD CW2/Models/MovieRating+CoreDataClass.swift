//
//  MovieRating+CoreDataClass.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//
//

import Foundation
import CoreData

@objc(MovieRating)
public class MovieRating: NSManagedObject {
    convenience init(comment: String, id: String, movieid: String, rating: Int32,
                     userid: String, movierelationship: Movie, userrelationship: User,
                     insertIntoManagedObjectContext context : NSManagedObjectContext) {
        self.init(context: context)
        self.comment = comment
        self.id = id
        self.movieid = movieid
        self.rating = rating
        self.userid = userid
        self.movierelationship = movierelationship
        self.userrelationship = userrelationship
    }
}
