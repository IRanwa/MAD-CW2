//
//  Movie+CoreDataClass.swift
//  MAD CW2
//
//  Created by user235597 on 8/16/23.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    convenience init(coverimage: String, desc: String, id: Int64, imdblink: String,
                     name: String, rating: Double, useroverallrating: Double, youtubelink: String,
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
    }
}
