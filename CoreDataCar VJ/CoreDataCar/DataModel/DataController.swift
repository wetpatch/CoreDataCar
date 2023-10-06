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
    
    func addCar(make: String, model: String, regno: String, purchasedate: Date, mileagestarting: Int64, purchasecost: Double, regdate: Date, motdate: Date, taxdate: Date, insurancedate: Date, context: NSManagedObjectContext) {
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
        car.insurancedate = insurancedate
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
        car.addToCarExpense(expense)
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
    
    func addFuel(litres: Double, cost: Double, mileage: Int64, selectedDate: Date, fuelcost: Double, context: NSManagedObjectContext) {
        let fuel = Fuel(context: context)
       fuel.fuelid = UUID()
        fuel.fueldate = selectedDate
        fuel.mileagenow = mileage
        fuel.litresnow = litres
        fuel.costperlitre = cost
        fuel.fuelcostnow = fuelcost
        save(context: context)
    }

    func addFueltoCar(car: Car,  fuel: Fuel, mileage: Int64, totlitres: Double, totcost: Double,
                 context: NSManagedObjectContext) {
        car.mileagenow = mileage
        car.litrestot = totlitres
        car.fuelcosttot = totcost
        car.addtoFuelCost(fuel)
        save(context: context)
    }
    
    func getFuel(context: NSManagedObjectContext) -> Array<Fuel> {
        let fetchRequest: NSFetchRequest<Fuel> = Fuel.fetchRequest()
        let result = try? context.fetch(fetchRequest)
        
        guard let result = result, !result.isEmpty else {
            return []
        }
        return result
    }
    
    func deleteFuel(context: NSManagedObjectContext, fuel: Fuel){
        context.delete(fuel)
        save(context: context)
    }
    
    func addInsurance(comment: String, contact: String, cost: Int64, selectedDate: Date, name: String, policyno: String, context: NSManagedObjectContext) {
        let insurance = Insurance(context: context)
        insurance.insuranceid = UUID()
        insurance.comment = comment
        insurance.cost = cost
        insurance.insdate = selectedDate
        save(context: context)
    }

    func addInsurancetoCar(car: Car,  insurance: Insurance, insurername: String, insurerpolicy: String, insurercontact: String, insurancecosttot: Int64,
                 context: NSManagedObjectContext) {
        car.insurername = insurername
        car.insurerpolicy = insurerpolicy
        car.insurercontact = insurercontact
        car.insurancecosttot = insurancecosttot
        car.addToCarInsurance(insurance)
        save(context: context)
    }
    
    func getInsurance(context: NSManagedObjectContext) -> Array<Insurance> {
        let fetchRequest: NSFetchRequest<Insurance> = Insurance.fetchRequest()
        let result = try? context.fetch(fetchRequest)
        
        guard let result = result, !result.isEmpty else {
            return []
        }
        return result
    }
    
    func deleteInsurance(context: NSManagedObjectContext, insurance: Insurance){
        context.delete(insurance)
        save(context: context)
    }
    
    func editCar(car: Car, make: String, model: String, regno: String, purchasedate: Date, mileagestarting: Int64, purchasecost: Double, regdate: Date, taxdate: Date, motdate: Date, insurancedate: Date, context: NSManagedObjectContext) {
        car.make = make
        car.model = model
        car.regno = regno
        car.purchasedate = purchasedate
        car.mileagestarting = mileagestarting
        car.purchasecost = purchasecost
        car.regdate = regdate
        car.taxdate = taxdate
        car.motdate = motdate
        car.insurancedate = insurancedate
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
    
    func insurance(car: Car,  insurancecosttot: Int64,
                   context: NSManagedObjectContext) {
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
