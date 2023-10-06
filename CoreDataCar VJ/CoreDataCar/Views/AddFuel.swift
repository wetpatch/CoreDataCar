//
//  AddFuel.swift
//  CoreDataCar
//
//  Created by Chris Milne on 01/10/2023.
//

import SwiftUI
import CoreData

struct AddFuel: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    
    @StateObject var car: Car
    @State private var costperlitre:Double = 0.0
    @State private var fuelcostnow: Double = 0.0
    @State private var fuelcosttot:Double = 0.0
    @State private var fueldate = Date()
    @State private var litresnow:Double = 0.0
    @State private var mileagenow:Int64 = 0
    
    @State private var fueldateString = ""
    @State private var selectedDate = Date()
    
    @State var cost:Double = 0.0
    @State var fdate = Date()
    @State var litres:Double = 0.0
    @State var mileage:Int64 = 0
    @State var fuelcost:Double = 0.0
    
    @State private var isEditing = false

    
    var body: some View {
        
        Text("Add Fuel")
            .bold()
            .foregroundColor(.blue)
            .font(Font.custom("Avenir Heavy", size: 20))
        
        
        //       HStack {
        Form {
            Section {
                let columns = [GridItem(.fixed(120)), GridItem(.fixed(175))]
                LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 5) {
                    Text(" Fuel Date")
                    DatePicker("   Fuel Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(Dates(dateString: $fueldateString))
                        .onChange(of: selectedDate) { newDate in
                            fueldateString = Dates.dateFormatter.string(from: newDate)
                        }  /// NewDate
                    
                    Text(" No of Litres")
                    TextField("Litres", value: $litres, format: .number)
                        .textFieldStyle(.roundedBorder).gridCellColumns(1)
                    Text(" Price per Litre £")
                    TextField(" Cost", value: $cost, format: .number)
                        .textFieldStyle(.roundedBorder)
                    Text(" Mileage")
                    TextField("Mileage", value: $mileage, format: .number)
                        .textFieldStyle(.roundedBorder).gridCellColumns(1)
                    
                    Spacer()
                    Button(action: addFuel) {
                        Label("Press PUMP to Update", systemImage: "fuelpump.circle").labelStyle(.titleAndIcon)
                            .frame(width: 300, height: 44, alignment: .leading)
                    } /// Button
                }   /// LazyGrid
            }   /// Section
        } /// Form
        .font(.system(size: 14, weight: .bold))
        
       NavigationView {
           VStack(alignment: .leading) {

               List {
                    let rows = [GridItem(.adaptive(minimum: 180))]

                       ForEach(car.fuelCostArray) { fuel in
                           LazyHGrid(rows: rows, spacing: 50 )      {
                           Text(Dates.aString(date: fuel.fueldate ?? Date()))
                           Text(String(format: "%.0f", fuel.litresnow))
                           Text("£ " + String(format: "%.0f", fuel.costperlitre * fuel.litresnow))
                           Text("\(fuel.mileagenow)")
                           } /// LazyGrid
                           }.onDelete(perform: deleteFuel)      /// For Each
                }   /// List
                .font(.system(size: 14, weight: .semibold))
               
                Text("                                    Total Fuel Cost: £ " + String(format: "%.0f", car.fuelCostArray.reduce(0.0)
                    { $0 + ($1.fuelcostnow) }))
                .font(.system(size: 14, weight: .semibold))
                
            } /// VStack

           
            
            .toolbar {
               ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()   /// Displays an Edit button
                } /// ToolbarItem
            } /// ToolBar
            .buttonStyle(.borderedProminent)
            .sheet(isPresented: $isEditing) {
                ListView()
                
            } /// sheet
        } /// Nav View
        .navigationViewStyle(.stack)
        .navigationTitle("\(car.make!) \(car.model!) \(car.regno!)")
        .bold()
        .foregroundColor(.black)
        .font(Font.custom("Avenir Heavy", size: 18))
        
        

        Button("Return")
        {
            dismiss()
        }                                   ///Button
        .buttonStyle(.borderedProminent)
        .padding([.bottom, .leading], 20)  
        
    } /// Body
    
    private func deleteFuel(offsets: IndexSet) {
        withAnimation {
            offsets.map { car.fuelCostArray[$0] }
                .forEach { fuel in
                    managedObjectContext.delete(fuel)
                }
            DataController().save(context: managedObjectContext)
        } /// func
    } /// Animation

    private func addFuel() {
        withAnimation {
            let newFuel = Fuel(context: managedObjectContext)
            newFuel.litresnow = Double(litres)
            newFuel.costperlitre = Double(cost)
            newFuel.mileagenow = Int64(mileage)
            newFuel.fueldate = selectedDate
            newFuel.fuelcostnow = Double(litres * cost)
            car.addtoFuelCost(newFuel)
            DataController().save(context: managedObjectContext)
            updateTotFuel()
        }
    }

    private func updateTotFuel() {
        /* The reduce function is used to iterate through car.expensesArray and calculate the total fuel cost. The initial value is 0.0, and for each fuelcost ($1), the fuelcost is added to the accumulator ($0).
         The nil coalescing operator (??) is used to handle the case where fuelcost might be nil (optional), ensuring that it's treated as 0.0 in the calculation.
         
         After running this code, the total fuelcost will be stored in car.fuelcosttot. This property will be updated whenever the fuelcost in car.fuelArray change, ensuring that it always reflects the correct total.
         */
        car.fuelcosttot = car.fuelCostArray.reduce(0.0) { $0 + ($1.fuelcostnow ) }
        car.litrestot = car.fuelCostArray.reduce(0.0) { $0 + ($1.litresnow ) }
        car.mileagenow = mileage
        DataController().save(context: managedObjectContext)
    }
    
    
}
