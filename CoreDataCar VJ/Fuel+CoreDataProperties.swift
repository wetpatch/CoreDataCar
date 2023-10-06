//
//  Fuel+CoreDataProperties.swift
//  CoreDataCar
//
//  Created by Chris Milne on 01/10/2023.
//
//

import Foundation
import CoreData


extension Fuel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Fuel> {
        return NSFetchRequest<Fuel>(entityName: "Fuel")
    }
    @NSManaged public var fuelid: UUID?
    @NSManaged public var fueldate: Date?
    @NSManaged public var mileagenow: Int64
    @NSManaged public var litresnow: Double
    @NSManaged public var costperlitre: Double
    @NSManaged public var fuelcostnow: Double
    @NSManaged public var fuelcosttot: Double
    @NSManaged public var fuelCost: Car?
    
 //   @NSManaged public var fuel: Car?
 //   @NSManaged public var cars: Car?

}

extension Fuel : Identifiable {

}
