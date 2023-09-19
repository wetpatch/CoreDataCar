//
//  MainCarView.swift
//  CoreDataCar
//
//  Created by Chris Milne on 27/06/2023.
//

import SwiftUI

struct MainCarView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    /*   Each button uses its respective state variable, ensuring that tapping the buttons will toggle the correct boolean value and present the corresponding sheet view */
    @State private var showingEditView = false
    @State private var showingAddView = false
    @State private var showingExtraView = false
    @State private var showingInsurance = false
    @State private var showingExpense = false
    
    var car: FetchedResults<Car>.Element
    //    var expense: FetchedResults<Expense>.Element
    
    @State private var make = ""
    @State private var model = ""
    @State private var regno = ""
    @State private var fuelcosttot:Double = 0.0
    @State private var purchasedate:Date = Date()
    @State private var mileagestarting:Int64  = 0
    @State private var purchasecost:Double = 0.0
    @State private var insurancecosttot:Int64  = 0
    @State private var litrestot:Double = 0.0
    @State private var insurancedate:Date = Date()
    @State private var regdate:Date = Date()
    @State private var motdate:Date = Date()

    var body: some View {

        Text("Main View")
            .bold()
            .foregroundColor(.blue)
            .font(Font.custom("Avenir Heavy", size: 24))
        Text("  Edit      Fuel    Extra   Insurance  Expenses")
            .allowsTightening(true)
            .lineLimit(1)
            .minimumScaleFactor(0.5)
        
        //Work out No of Days  since the Start
        let calendar = Calendar.current
        let firstDate = car.purchasedate!
        let ToDate = Date()
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: firstDate)
        let date2 = calendar.startOfDay(for: ToDate)
        let components = calendar.dateComponents([Calendar.Component.day], from: date1, to: date2)
        // This will return the number of day(s) between dates
        let daysDiff = components.day
        //Work out Cost per Day and Month
        let costperDay: Double = (car.fuelcosttot) / Double(daysDiff ?? 0)
        let costperMonth: Double = costperDay * 30
        
        
        
        NavigationView {
            
            VStack (alignment: .leading, spacing: 10) {
                List {
                    let columns = [GridItem(.fixed(175)), GridItem(.fixed(175))]
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )      {
                        
                        Text("   Make/Model").gridCellColumns(1)
                        Text("\(car.make!) \(car.model!)").gridCellColumns(2)
                        // .font(.system(size: 12))
                        Text("   Reg Number: ").gridCellColumns(1)
                        Text("\(car.regno ?? "")").gridCellColumns(2)
                        Text("  Registered Date").gridCellColumns(1)
                        Text(DataController.aString(date: car.regdate ?? Date())).gridCellColumns(2)
                        Text("  Starting Mileage").gridCellColumns(1)
                        Text(" \(car.mileagestarting)").gridCellColumns(2)
                        Text("  Purchase Cost").gridCellColumns(1)
                        Text("£ " + String(format: "%.0f", car.purchasecost)).gridCellColumns(2)
                        
                    }  /// LazyGrid
                    let average = Double(car.mileagenow - car.mileagestarting) / (car .litrestot / 4.536)
                    
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )      {
                        Text("  Purchase Date").gridCellColumns(1)
                        Text(DataController.aString(date: car.purchasedate ?? Date())).gridCellColumns(2)
                        Text("  Tax Date").gridCellColumns(1)
                        Text(DataController.aString(date: car.taxdate ?? Date())).gridCellColumns(2)
                        Text("  MOT Date").gridCellColumns(1)
                        Text(DataController.aString(date: car.motdate ?? Date())).gridCellColumns(2)
                        Text("  Insurance Date").gridCellColumns(1)
                        Text(DataController.aString(date: car.insurancedate ?? Date())).gridCellColumns(2)
                        Text("  Average MPG").gridCellColumns(1);
                        Text(String(format: "%.1f", average)).gridCellColumns(2)

                        
                        
                    }/// LazyGrid
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )      {
                        Text("  Tot Fuel Cost").gridCellColumns(1);
                        Text("£ " + String(format: "%.0f", car.fuelcosttot)).gridCellColumns(2)
                        Text("  Tot Insurance").gridCellColumns(1);
                        Text("£ \( car.insurancecosttot)").gridCellColumns(2)
                        Text("  Tot Expenses").gridCellColumns(1)
                        Text("£ " + String(format: "%.0f", car.expensestot)).gridCellColumns(2)
                        Text("  Fuel Cost Daily").gridCellColumns(1)
                        Text("£ " + String(format: "%.2f", costperDay)).gridCellColumns(2)
                        Text("  Fuel Cost Monthly").gridCellColumns(1)
                        Text("£ " + String(format: "%.0f", costperMonth)).gridCellColumns(2)
                        //                      Spacer()
                    } /// LazyGrid
                }  /// VStack
            } // List
            
            /// Displays  "Edit   Fuel   Extra   Insurance  Expenses" at the top of the screen

            .toolbar {
                Button {
                    showingEditView.toggle()
                    
                } label: {
                    Label("edit", systemImage: "square.and.pencil")
                }.position(x: 10, y: 20)
                .sheet(isPresented: $showingEditView) {
                    EditCarView(car:car)
                } /// sheet
                Button {
                    showingAddView.toggle()
                } label: {
                    Label("fuel", systemImage: "fuelpump.circle")
                }.position(x: 18, y: 20)   /// Label
                .sheet(isPresented: $showingAddView) {
                    AddFuelView(car:car)
                } /// sheet
                Button {
                    showingExtraView.toggle()
                } label: {
                    Label("extra", systemImage: "list.bullet")
                }.position(x: 20, y: 20)   /// Label
                .sheet(isPresented: $showingExtraView) {
                    ExtraDetailsView(car:car)
                } /// sheet
                Button {
                    showingInsurance.toggle()
                } label: {
                    Label("insurance", systemImage: "cross.vial")
                }.position(x: 30, y: 20)   /// Label
                .sheet(isPresented: $showingInsurance) {
                    Insurance(car:car)
                } /// sheet
                
                Button {
                    showingExpense.toggle()
                } label: {
                    Label("Expenses", systemImage: "sterlingsign.circle")
                }.position(x: 50, y: 20)   /// Label
                .sheet(isPresented: $showingExpense) {
                    AddExpense(car:car)
                } /// sheet
              Text("            ").padding()
                
            } /// .toolbar
        } /// NavigationView


    } /// Body
}  //// Struct


