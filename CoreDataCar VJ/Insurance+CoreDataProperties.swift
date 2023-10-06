//
//  Insurance+CoreDataProperties.swift
//  CoreDataCar
//
//  Created by Chris Milne on 04/10/2023.
//

import Foundation
import CoreData


extension Insurance {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Insurance> {
        return NSFetchRequest<Insurance>(entityName: "Insurance")
    }
    @NSManaged public var insuranceid: UUID?
    @NSManaged public var comment: String?
    @NSManaged public var cost: Int64
    @NSManaged public var insdate: Date?
    
    @NSManaged public var carInsurance: Car?
//    @NSManaged public var cars: Car?
}

extension Insurance : Identifiable {

}
