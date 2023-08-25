//
//  Movie+CoreDataClass.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    convenience init(coverimage: String, desc: String, id: String, imdblink: String,
                     name: String, rating: Double, useroverallrating: Int32, youtubelink: String,
                     releaseDate: Date?, genres: String,
                     insertIntoManagedObjectContext context : NSManagedObjectContext) {
        self.init(context: context)
        self.coverimage = coverimage
        self.desc = desc
        self.id = id
        self.imdblink = imdblink
        self.name = name
        self.rating = rating
        self.useroverallrating = useroverallrating
        self.youtubelink = youtubelink
        self.releaseDate = releaseDate
        self.genres = genres
    }
}
