//
//  Car+CoreDataProperties.swift
//  CoreDataCar
//
//  Created by Chris Milne on 01/10/2023.
//
//

import Foundation
import CoreData


extension Car {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Car> {
        return NSFetchRequest<Car>(entityName: "Car")
    }

    @NSManaged public var colour: String?
    @NSManaged public var costpermile: Double
    @NSManaged public var enginesize: String?
    @NSManaged public var expensestot: Double
    @NSManaged public var fuelcosttot: Double
    @NSManaged public var fueltype: String?
    @NSManaged public var id: UUID?
    @NSManaged public var insurancecosttot: Int64
    @NSManaged public var insurancedate: Date?
    @NSManaged public var insurercontact: String?
    @NSManaged public var insurername: String?
    @NSManaged public var insurerpolicy: String?
    @NSManaged public var litrestot: Double
    @NSManaged public var maintenancecost: Int64
    @NSManaged public var make: String?
    @NSManaged public var mileagestarting: Int64
    @NSManaged public var model: String?
    @NSManaged public var motdate: Date?
    @NSManaged public var oiltype: String?
    @NSManaged public var purchasecost: Double
    @NSManaged public var purchasedate: Date?
    @NSManaged public var regdate: Date?
    @NSManaged public var regno: String?
    @NSManaged public var servicedue: String?
    @NSManaged public var taxdate: Date?
    @NSManaged public var tyrepressure: String?
    @NSManaged public var variant: String?
    @NSManaged public var version: String?
    @NSManaged public var vin: String?
    @NSManaged public var mileagenow: Int64
    
    @NSManaged public var carExpense: NSSet?
    @NSManaged public var fuelCost: NSSet?
    @NSManaged public var carInsurance: NSSet?

    @NSManaged public var expenses: NSSet?
    @NSManaged public var fuel: NSSet?
    @NSManaged public var insurance: NSSet?
    
    public var unwrappedMake: String {
        make ?? "Unknown Make"
    } /// public var1
    
    public var carExpenseArray: Array<Expense> {
        let expenseSet = carExpense as? Set<Expense> ?? []
        return expenseSet.sorted { $0.expensedate ?? Date() > $1.expensedate ?? Date() }
    } /// Public var2
    
    public var fuelCostArray: Array<Fuel> {
        let fuelSet = fuelCost as? Set<Fuel> ?? []
        return fuelSet.sorted { $0.fueldate ?? Date() > $1.fueldate ?? Date() }
    }/// Public var3
    
    public var carInsuranceArray: Array<Insurance> {
        let insuranceSet = carInsurance as? Set<Insurance> ?? []
        return insuranceSet.sorted { $0.insdate ?? Date() > $1.insdate ?? Date() }
    }/// Public var4
} /// Extension Car

// MARK: Generated accessors for carExpense
extension Car {

    @objc(addCarExpenseObject:)
    @NSManaged public func addToCarExpense(_ value: Expense)  /// Calls DataController addExpenseToCar()

    @objc(removeCarExpenseObject:)
    @NSManaged public func removeFromCarExpense(_ value: Expense)

    @objc(addCarExpense:)
    @NSManaged public func addToCarExpense(_ values: NSSet) /// Calls DataController addExpenseToCar()

    @objc(removeCarExpense:)
    @NSManaged public func removeFromCarExpense(_ values: NSSet)

}

// MARK: Generated accessors for carInsurance
extension Car {

    @objc(addCarInsuranceObject:)
    @NSManaged public func addToCarInsurance(_ value: Insurance)  /// Calls DataController addInsuranceToCar()

    @objc(removeCarInsuranceObject:)
    @NSManaged public func removeFromCarInsurance(_ value: Insurance)

    @objc(addCarInsurance:)
    @NSManaged public func addToCarInsurance(_ values: NSSet) /// Calls DataController addInsuranceToCar()

    @objc(removeCarInsurance:)
    @NSManaged public func removeFromCarInsurance(_ values: NSSet)

}

// MARK: Generated accessors for fuelCost
extension Car {

    @objc(addFuelCostObject:)
    @NSManaged public func addtoFuelCost(_ value: Fuel) /// Calls DataController addFuelToCar()

    @objc(removeFuelCostObject:)
    @NSManaged public func removeFromFuelCost(_ value: Fuel)

    @objc(addFuelCost:)
    @NSManaged public func addtoFuelCost(_ values: NSSet)  /// Calls DataController addFuelToCar()

    @objc(removeFuelCost:)
    @NSManaged public func removeFromFuelCost(_ values: NSSet)

}

extension Car : Identifiable {

}
