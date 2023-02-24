//
//  User+CoreDataClass.swift
//  Practica_ios_Avanzado
//
//  Created by Enrique Poyato Ortiz on 15/2/23.
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
}

public extension User {
    
    @nonobjc class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }
    
    @NSManaged var email: String?
    
    
}

extension User: Identifiable {}
