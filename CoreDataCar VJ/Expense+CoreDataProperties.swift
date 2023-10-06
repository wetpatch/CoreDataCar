//
//  Expense+CoreDataProperties.swift
//  CoreDataCar
//
//  Created by Chris Milne on 01/10/2023.
//
//

import Foundation
import CoreData


extension Expense {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Expense> {
        return NSFetchRequest<Expense>(entityName: "Expense")
    }
    @NSManaged public var exit: UUID?
    @NSManaged public var expensecost: Double
    @NSManaged public var expensedate: Date?
    @NSManaged public var expensedetail: String?
    @NSManaged public var regnum: String?
    @NSManaged public var carExpense: Car?
//    @NSManaged public var cars: Car?
}

extension Expense : Identifiable {

}
