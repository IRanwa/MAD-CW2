//
//  User+CoreDataClass.swift
//  MAD CW2
//
//  Created by user239258 on 8/19/23.
//
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    convenience init(email: String, firstname: String, id: String, lastname: String,
                     password: String, phone: String?, usertype: String, title: String?,
                     insertIntoManagedObjectContext context : NSManagedObjectContext) {
        self.init(context: context)
        self.email = email
        self.firstname = firstname
        self.id = id
        self.lastname = lastname
        self.password = password
        self.phone = phone
        self.usertype = usertype
        self.title = title
    }
}
