//
//  Favourite+CoreDataProperties.swift
//  MAD CW2
//
//  Created by user239258 on 8/26/23.
//
//

import Foundation
import CoreData


extension Favourite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favourite> {
        return NSFetchRequest<Favourite>(entityName: "Favourite")
    }

    @NSManaged public var movieId: String?
    @NSManaged public var id: String?
    @NSManaged public var userId: String?

}

extension Favourite : Identifiable {

}
