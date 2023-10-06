//
//  AddCarView.swift


import SwiftUI

struct AddCarView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
 ///   Initial Details
    
    @State private var make = ""
    @State private var model = ""
    @State private var regno = ""
    @State private var mileagestarting:Int64 = 0
    @State private var purchasecost:Double = 0.0
    @State private var purchasedate = Date()
    @State private var regdate = Date()
    @State private var motdate = Date()
    @State private var taxdate = Date()
    @State private var insurancedate = Date()
    
    @State private var purchasedateString = ""
    @State private var regdateString = ""
    @State private var motdateString = ""
    @State private var taxdateString = ""
    @State private var insurancedateString = ""
    
    @State private var selectedDate = Date()

    var body: some View {
        Text("Add a Car to your files")
            .bold()
            .foregroundColor(.blue)
            .font(Font.custom("Avenir Heavy", size: 24))
        
        VStack {
            Form {
            Section {
                let columns = [GridItem(.fixed(120)), GridItem(.fixed(175))]
                LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )  {
                    Text("Car Make").gridCellColumns(1)
                    TextField("Car Make", text: $make).textFieldStyle(.roundedBorder)
                    Text("Car Model").gridCellColumns(1)
                    TextField("Car Model", text: $model).textFieldStyle(.roundedBorder)
                    Text("Reg Number").gridCellColumns(1)
                    TextField("Reg No", text: $regno).textFieldStyle(.roundedBorder)
                    Text("Starting Mileage").gridCellColumns(1)
                    TextField("Starting Mileage", value: $mileagestarting, format: .number).textFieldStyle(.roundedBorder)
                    Text("Purchase Cost £").gridCellColumns(1)
                    TextField("Purchase Cost", value: $purchasecost, format: .number ).textFieldStyle(.roundedBorder)
                }   /// LazyGrid
                
                LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 5 )  {
                    Text("Purchase Date").gridCellColumns(1)
                    DatePicker("Purchase Date", selection: $purchasedate, displayedComponents: .date)
                        .datePickerStyle(Dates(dateString: $purchasedateString))
                        
                        .onChange(of: purchasedate) { newDate in
                            purchasedateString = Dates.dateFormatter.string(from: newDate)
                        }  /// NewDate
                    Text("Registered Date").gridCellColumns(1)
                    DatePicker("Reg Date", selection: $regdate, displayedComponents: .date)
                        .datePickerStyle(Dates(dateString: $regdateString))
                        
                        .onChange(of: regdate) { newDate in
                            regdateString = Dates.dateFormatter.string(from: newDate)
                        }  /// NewDate
                    Text("MOT Date").gridCellColumns(1)
                    DatePicker("Mot Date", selection: $motdate, displayedComponents: .date)
                        .datePickerStyle(Dates(dateString: $motdateString))
                        
                        .onChange(of: motdate) { newDate in
                            motdateString = Dates.dateFormatter.string(from: newDate)
                        }  /// NewDate
                    Text("Tax Date").gridCellColumns(1)
                    DatePicker("Tax Date", selection: $taxdate, displayedComponents: .date)
                        .datePickerStyle(Dates(dateString: $taxdateString))
                        
                        .onChange(of: taxdate) { newDate in
                            taxdateString = Dates.dateFormatter.string(from: newDate)
                        }  /// NewDate
                    ///
                    Text("Insurance Renewal Date").gridCellColumns(1)
                    DatePicker("Insurance Date", selection: $insurancedate, displayedComponents: .date)
                        .datePickerStyle(Dates(dateString: $insurancedateString))
                        
                        .onChange(of: insurancedate) { newDate in
                            insurancedateString = Dates.dateFormatter.string(from: newDate)
                        }  /// NewDate



                        }  /// Lazygrid
            }   /// Section
        } /// Form
    }  // VStack
     
                HStack {
                    Spacer()
                    Button("Submit") {
  
                        DataController().addCar(make: make, model: model, regno: regno, purchasedate: purchasedate, mileagestarting: mileagestarting, purchasecost: purchasecost, regdate: regdate, motdate: motdate, taxdate: taxdate, insurancedate: insurancedate, context: managedObjectContext)

                        dismiss()
                        
                    } ///Button
                    Spacer()
                    Button("Exit") {
                        dismiss()
                    } ///Button
                    Spacer()
                } /// HStack
            }   /// Body
        } /// Struct

