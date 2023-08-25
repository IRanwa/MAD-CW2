//
//  Favourite+CoreDataClass.swift
//  MAD CW2
//
//  Created by user245466 on 8/26/23.
//
//

import Foundation
import CoreData

@objc(Favourite)
public class Favourite: NSManagedObject {
    convenience init(id: String, movieId: String, userId: String,
                     insertIntoManagedObjectContext context : NSManagedObjectContext) {
        self.init(context: context)
        self.id = id
        self.movieId = movieId
        self.userId = userId
    }
}
