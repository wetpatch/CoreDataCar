//
//  Insurance.swift
//  CoreDataCar
//
//  Created by Chris Milne on 04/07/2023.
//

import SwiftUI

struct Insurance: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var car: FetchedResults<Car>.Element
    
    /// Insurance Details
    @State private var insurancedate = Date()
    @State private var insurername = ""
    @State private var insurercontact = ""
    @State private var insurerpolicy = ""
    @State private var insurancecostnow:Int64 = 0
    @State private var insurancecosttot:Int64 = 0
    @State private var selectedDate = Date()
    @State private var dateString: String = ""
    @State private var insurancedateString: String = ""
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Change the date format to match your desired format
        return formatter
    }()
    
    var body: some View {
        
        VStack   {
                Text("Insurance")
                    .bold()
                    .foregroundColor(.blue)
                    .font(Font.custom("Avenir Heavy", size: 24))
                Text("\(car.make!) \(car.model!)")
                    .bold()
                    .foregroundColor(.red)
                    .font(Font.custom("Avenir Heavy", size: 24))

                    Section {
                        let columns = [GridItem(.fixed(120)), GridItem(.fixed(175))]
                        LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 5 )  {
                            Text("  Insurer").gridCellColumns(1)
                            TextField("Insurer", text: $insurername).textFieldStyle(.roundedBorder).gridCellColumns(2)
                            Text("  Policy No").gridCellColumns(1)
                            TextField("Policy No", text: $insurerpolicy).textFieldStyle(.roundedBorder).gridCellColumns(2)
                            Text("  Premium").gridCellColumns(1)
                            TextField("Premium", value: $insurancecostnow, format: .currency (code: "GBP")).textFieldStyle(.roundedBorder).gridCellColumns(2)
                            Text("  Renewal Date").gridCellColumns(1)
              DatePicker("Renewal Date", selection: $insurancedate, displayedComponents: .date)
                  .datePickerStyle(TextDatePickerStyle(dateString: $insurancedateString))
                  .gridCellColumns(2)
                  .onChange(of: insurancedate) { newDate in
                      insurancedateString = dateFormatter.string(from: newDate)
                  }  /// NewDate
                            Text("  Contact").gridCellColumns(1)
                            TextField("Contact", text: $insurercontact).textFieldStyle(.roundedBorder).gridCellColumns(2)

                                .onAppear {
                                    insurername = car.insurername ?? " "
                                    insurerpolicy = car.insurerpolicy ?? " "
                                    insurancecostnow = car.insurancecostnow
                                    insurercontact = car.insurercontact ?? " "
                                    insurancedate = insurancedate

                                    
                                } /// onAppear
                        }   /// LazyGrid
                    }  ///Section
                ///                        }  // Form
            } /// VStack
            HStack {
                Spacer()
                Button("Submit") {
                    DataController().insurance(car: car, insurancedate: insurancedate, insurername:  insurername, insurercontact: insurercontact, insurerpolicy: insurerpolicy, insurancecostnow: insurancecostnow, insurancecosttot: insurancecostnow + insurancecosttot,
                                                  context: managedObjectContext)
                    dismiss()
                } ///Button
                Spacer()
                Button("Exit") {
                    dismiss()
                } ///Button
                Spacer()
            } /// Hstack
    } /// Body
} /// struct
