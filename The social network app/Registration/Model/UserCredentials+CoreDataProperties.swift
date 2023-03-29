//
//  UserCredentials+CoreDataProperties.swift
//  The social network app
//
//  Created by Mykyta Babanin on 24.10.2022.
//
//

import Foundation
import CoreData


extension UserCredentials {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCredentials> {
        return NSFetchRequest<UserCredentials>(entityName: "UserCredentials")
    }

    @NSManaged public var name: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension UserCredentials : Identifiable {

}
