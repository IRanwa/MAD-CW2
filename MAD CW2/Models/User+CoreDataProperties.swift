//
//  User+CoreDataProperties.swift
//  MAD CW2
//
//  Created by user235597 on 8/16/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var firstname: String?
    @NSManaged public var id: String?
    @NSManaged public var lastname: String?
    @NSManaged public var password: String?
    @NSManaged public var phone: String?
    @NSManaged public var usertype: String?
    @NSManaged public var ratinguserrelationship: MovieRating?

}

extension User : Identifiable {

}
