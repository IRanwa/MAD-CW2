//
//  MovieRating+CoreDataClass.swift
//  MAD CW2
//
//  Created by user235597 on 8/16/23.
//
//

import Foundation
import CoreData

@objc(MovieRating)
public class MovieRating: NSManagedObject {
    convenience init(comment: String, id: Int64, movieid: Int64, rating: Double,
                     userid: Int64, movierelationship: Movie, userrelationship: User,
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
