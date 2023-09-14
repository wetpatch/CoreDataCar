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
    
    @State private var purchasedateString = ""
    @State private var regdateString = ""
    @State private var motdateString = ""
    @State private var taxdateString = ""
    
    @State private var selectedDate = Date()

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Change the date format to match your desired format
        return formatter
    }()
    
    var body: some View {
        Text("Add Car")
            .bold()
            .foregroundColor(.blue)
            .font(Font.custom("Avenir Heavy", size: 24))
        
        VStack {
            Form {
            Section {
                let columns = [GridItem(.fixed(120)), GridItem(.fixed(175))]
                LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )  {
                    Text("Car Make").gridCellColumns(1)
                    TextField("Car Make", text: $make).textFieldStyle(.roundedBorder).gridCellColumns(2)
                    Text("Car Model").gridCellColumns(1)
                    TextField("Car Model", text: $model).textFieldStyle(.roundedBorder).gridCellColumns(2)
                    Text("Reg Number").gridCellColumns(1)
                    TextField("Reg No", text: $regno).textFieldStyle(.roundedBorder).gridCellColumns(2)
                    Text("Starting Mileage").gridCellColumns(1)
                    TextField("Starting Mileage", value: $mileagestarting, format: .number).textFieldStyle(.roundedBorder).gridCellColumns(2)
                    Text("Purchase Cost").gridCellColumns(1)
                    TextField("Purchase Cost", value: $purchasecost, format: .currency (code: "GBP ")).textFieldStyle(.roundedBorder).gridCellColumns(2)
                }   /// LazyGrid
                
                LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 5 )  {
                    Text("Purchase Date").gridCellColumns(1)
                    DatePicker("Purchase Date", selection: $purchasedate, displayedComponents: .date)
                        .datePickerStyle(TextDatePickerStyle(dateString: $purchasedateString))
                        .gridCellColumns(2)
                        .onChange(of: purchasedate) { newDate in
                            purchasedateString = dateFormatter.string(from: newDate)
                        }  /// NewDate
                    Text("Registered Date").gridCellColumns(1)
                    DatePicker("Reg Date", selection: $regdate, displayedComponents: .date)
                        .datePickerStyle(TextDatePickerStyle(dateString: $regdateString))
                        .gridCellColumns(2)
                        .onChange(of: regdate) { newDate in
                            regdateString = dateFormatter.string(from: newDate)
                        }  /// NewDate
                    Text("MOT Date").gridCellColumns(1)
                    DatePicker("Mot Date", selection: $motdate, displayedComponents: .date)
                        .datePickerStyle(TextDatePickerStyle(dateString: $motdateString))
                        .gridCellColumns(2)
                        .onChange(of: motdate) { newDate in
                            motdateString = dateFormatter.string(from: newDate)
                        }  /// NewDate
                    Text("Tax Date").gridCellColumns(1)
                    DatePicker("Tax Date", selection: $taxdate, displayedComponents: .date)
                        .datePickerStyle(TextDatePickerStyle(dateString: $taxdateString))
                        .gridCellColumns(2)
                        .onChange(of: taxdate) { newDate in
                            taxdateString = dateFormatter.string(from: newDate)
                        }  /// NewDate
                    ///
                    ///
                    ///
                    ///
                        }  /// Lazygrid
            }   /// Section
        } /// Form
    }  // VStack
     
                HStack {
                    Spacer()
                    Button("Submit") {
  
                        DataController().addCar(make: make, model: model, regno: regno, purchasedate: purchasedate, mileagestarting: mileagestarting, purchasecost: purchasecost, regdate: regdate, motdate: motdate, taxdate: taxdate, context: managedObjectContext)

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

