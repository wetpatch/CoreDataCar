//
//  AddFuelView.swift
//  CoreDataCar
//
//  Created by Chris Milne on 26/08/2023.
//

import SwiftUI

struct AddFuelView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var car: FetchedResults<Car>.Element
    @State private var fueldate = Date()
    @State private var mileagenow:Int64  = 0
    @State private var litresnow:Double = 0.0
    @State private var litrestot:Double = 0.0
    @State private var costperlitre:Double = 0.0
    @State private var selectedDate = Date()
    @State private var dateString: String = ""
    @State private var fueldateString: String = ""
    @State private var fuelcostnow:Double = 0.0
    @State private var fuelcosttot:Double = 0.0
    
    @State var cost: Double = 0.0
    @State var mileage: Int64 = 0
    @State var litres: Double = 0.0

    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Change the date format to match your desired format
        return formatter
    }()
    
    var body: some View {

        VStack   {

                Text("Add Fuel")
                    .bold()
                    .foregroundColor(.blue)
                    .font(Font.custom("Avenir Heavy", size: 24))
                Text("\(car.make!) \(car.model!)")
                    .bold()
                    .foregroundColor(.red)
                    .font(Font.custom("Avenir Heavy", size: 24))

            
            Form {
                Section {
                    let columns = [GridItem(.fixed(175)), GridItem(.fixed(175))]
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )  {                    Text("  Fuel Date").gridCellColumns(1)
                    DatePicker("Fuel Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(TextDatePickerStyle(dateString: $fueldateString))
                        .gridCellColumns(2)
                        .onChange(of: fueldate) { newDate in
                            fueldateString = dateFormatter.string(from: newDate)
                        }  /// NewDate
                        Text("   No of Litres").gridCellColumns(1)
                        TextField("Litres quantity", value: $litres, format: .number).textFieldStyle(.roundedBorder).gridCellColumns(2)
                        Text("  Cost per Litre").gridCellColumns(1)
                        TextField("Cost per Litre", value: $cost, format: .number).textFieldStyle(.roundedBorder).gridCellColumns(2)
                        Text("  Current Mileage").gridCellColumns(1)
                        TextField("Current Mileage", value: $mileage, format: .number).textFieldStyle(.roundedBorder).gridCellColumns(2)
                    }  /// LazyGrid
                    ///
                    .onAppear {
                        litresnow = litres
                        fuelcostnow = litres * cost
                        litrestot = litres + car.litrestot
                        costperlitre = cost
                            } /// onAppear
                    
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )  {
                        Text("  Fuel Cost").gridCellColumns(1);
                        Text("£ " + String(format: "%.2f", litres * cost)).gridCellColumns(2)
                        Text("  Tot Litres").gridCellColumns(1);
                        Text(String(format: "%.1f", litres + car.litrestot)).gridCellColumns(2)
                        Text("  Tot Gallons").gridCellColumns(1);
                        Text(String(format: "%.2f", ((litres + car.litrestot) / 4.536))).gridCellColumns(2)
                    .onAppear {
                        mileagenow = mileage
                        fueldate = selectedDate
                            } /// onAppear
                    }  /// LazyGrid
                } /// Section
           } /// Form
                        HStack {
                            Spacer()
                            Button("Submit") {
                                DataController().addFuel(car: car, fueldate:  selectedDate, litresnow: litres,  costperlitre: cost, mileagenow: mileage, fuelcostnow: litres * cost, litrestot: litres + litrestot, fuelcosttot: (litres * cost) + fuelcosttot,
                                                         context: managedObjectContext)
                                dismiss()
                            } ///Button
                            Spacer()
                            Button("Exit") {
                                dismiss()
                            } /// Button
                            Spacer()
                            }
                        } /// Hstack
    } /// Body
} /// struct

