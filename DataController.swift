//
//  DataController.swift
//  CoreDataCar
//
//  Created by Chris Milne on 22/06/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "CarModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            context.rollback()
            print("Could not save the Data")
        }
    }
    
    func addCar(make: String, model: String, regno: String, purchasedate: Date, mileagestarting: Int64, purchasecost: Double, regdate: Date, motdate: Date, taxdate: Date, context: NSManagedObjectContext) {
        let car = Car(context: context)
        car.id = UUID()
        car.make = make
        car.model = model
        car.regno = regno
        car.purchasedate = purchasedate
        car.mileagestarting = mileagestarting
        car.purchasecost = purchasecost
        car.regdate = regdate
        car.motdate = motdate
        car.taxdate = taxdate
        save(context: context)
    }

    func addExpense(expensedate: Date, expensedetail: String, expensecost: Double, regnum: String, context: NSManagedObjectContext) {
        let expense = Expense(context: context)
        expense.exit = UUID()
        expense.expensedate = expensedate
        expense.expensedetail = expensedetail
        expense.expensecost = expensecost
        expense.regnum = regnum
        save(context: context)
    }
    
    func addExpenseToCar(context: NSManagedObjectContext, car: Car, expense: Expense) {
        car.addToExpenses(expense)
        save(context: context)
    }
    
    
    
    func getExpenses(context: NSManagedObjectContext) -> Array<Expense> {
        let fetchRequest: NSFetchRequest<Expense> = Expense.fetchRequest()
        let result = try? context.fetch(fetchRequest)
        
        guard let result = result, !result.isEmpty else {
            return []
        }
        return result
    }
    
    func deleteExpense(context: NSManagedObjectContext, expense: Expense){
        context.delete(expense)
        save(context: context)
    }
    
    func editCar(car: Car, make: String, model: String, regno: String, purchasedate: Date, mileagestarting: Int64, purchasecost: Double, regdate: Date, taxdate: Date, motdate: Date, context: NSManagedObjectContext) {
        car.make = make
        car.model = model
        car.regno = regno
        car.purchasedate = purchasedate
        car.mileagestarting = mileagestarting
        car.purchasecost = purchasecost
        car.regdate = regdate
        car.taxdate = taxdate
        car.motdate = motdate
        save(context: context)
    }
    func addFuel(car: Car, fueldate: Date, litresnow: Double, costperlitre: Double, mileagenow: Int64, fuelcostnow: Double, litrestot: Double, fuelcosttot: Double,
                 context: NSManagedObjectContext) {
        car.fueldate = fueldate
        car.mileagenow = mileagenow
        car.litresnow  = litresnow
        car.costperlitre = costperlitre
        car.fuelcostnow = fuelcostnow
        car.litrestot = litrestot
        car.fuelcosttot = fuelcosttot
        save(context: context)
    }
    
    func extraDetails(car: Car, fueltype: String, enginesize: String, vin: String, version: String, colour: String, tyrepressure: String, oiltype: String, context: NSManagedObjectContext) {
        car.fueltype = fueltype
        car.enginesize = enginesize
        car.vin  = vin
        car.version = version
        car.colour = colour
        car.tyrepressure = tyrepressure
        car.oiltype = oiltype
        save(context: context)
    }
    
    func insurance(car: Car, insurancedate: Date, insurername: String, insurercontact: String, insurerpolicy: String, insurancecostnow: Int64, insurancecosttot: Int64,
                   context: NSManagedObjectContext) {
        car.insurancedate = insurancedate
        car.insurername = insurername
        car.insurercontact = insurercontact
        car.insurerpolicy = insurerpolicy
        car.insurancecostnow = insurancecostnow
        car.insurancecosttot = insurancecosttot
        save(context: context)
    }
    
    static func aString(date: Date) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let strDate = formatter.string(from: date)
        return strDate
    }
}
