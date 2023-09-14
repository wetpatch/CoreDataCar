//  EditCarView.swift


import SwiftUI

struct EditCarView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var car: FetchedResults<Car>.Element

    @State private var make = ""
    @State private var model = ""
    @State private var regno = ""
    @State private var purchasedate = Date()
    @State private var regdate = Date()
    @State private var motdate = Date()
    @State private var taxdate = Date()
    @State private var mileagestarting:Int64  = 0
    @State private var purchasecost:Double = 0.0
    @State private var purchasedateString = ""
    @State private var regdateString = ""
    @State private var motdateString = ""
    @State private var taxdateString = ""

    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Change the date format to match your desired format
        return formatter
    }()

    var body: some View {
        
        VStack   {

                Text("Edit Car")
                    .bold()
                    .foregroundColor(.blue)
                    .font(Font.custom("Avenir Heavy", size: 24))
            Form {
                Section {
                    let columns = [GridItem(.fixed(175)), GridItem(.fixed(175))]
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )  {
                        Text("   Car Make").gridCellColumns(1)
                        TextField("Car Make", text: $make).textFieldStyle(.roundedBorder).gridCellColumns(2)
                        Text("   Car Model").gridCellColumns(1)
                        TextField("Car Model", text: $model).textFieldStyle(.roundedBorder).gridCellColumns(2)
                        Text("   Reg Number").gridCellColumns(1)
                        TextField("Reg No", text: $regno).textFieldStyle(.roundedBorder).gridCellColumns(2)
                        Text("   Starting Mileage").gridCellColumns(1)
                        TextField("Starting Mileage", value: $mileagestarting, format: .number).textFieldStyle(.roundedBorder).gridCellColumns(2)
                        
                    }   /// LazyGrid
                    
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )  {
                        
                        Text("   Purchase Cost").gridCellColumns(1)
                        TextField("Purchase Cost", value: $purchasecost, format: .currency (code: "GBP ")).textFieldStyle(.roundedBorder).gridCellColumns(2)
                        Text("   Purchase Date").gridCellColumns(1)
                        DatePicker("Purchase Date", selection: $purchasedate, displayedComponents: .date)
                            .datePickerStyle(TextDatePickerStyle(dateString: $purchasedateString))
                            .gridCellColumns(2)
                            .onChange(of: purchasedate) { newDate in
                                purchasedateString = dateFormatter.string(from: newDate)
                            }  /// NewDate
                        Text("   Registration Date").gridCellColumns(1)
                        DatePicker("Reg Date", selection: $regdate, displayedComponents: .date)
                            .datePickerStyle(TextDatePickerStyle(dateString: $regdateString))
                            .gridCellColumns(2)
                            .onChange(of: regdate) { newDate in
                                regdateString = dateFormatter.string(from: newDate)
                            }  /// NewDate
                        Text("   TAX Date").gridCellColumns(1)
                        DatePicker("Tax Date", selection: $taxdate, displayedComponents: .date)
                            .datePickerStyle(TextDatePickerStyle(dateString: $taxdateString))
                            .gridCellColumns(2)
                            .onChange(of: taxdate) { newDate in
                                taxdateString = dateFormatter.string(from: newDate)
                            }  /// NewDate
                        Text("   MOT Date").gridCellColumns(1)
                        DatePicker("MOT Date", selection: $motdate, displayedComponents: .date)
                            .datePickerStyle(TextDatePickerStyle(dateString: $motdateString))
                            .gridCellColumns(2)
                            .onChange(of: motdate) { newDate in
                                motdateString = dateFormatter.string(from: newDate)
                            }  /// NewDate

 
 
                    }  /// LazyGrid
                } /// Form
            } /// Section
      .onAppear {
          make = car.make!
          model = car.model!
          regno = car.regno!
          mileagestarting = car.mileagestarting
          purchasecost = car.purchasecost
          purchasedate = car.purchasedate!
          regdate = car.regdate ?? Date()
          motdate = car.motdate ?? Date()
          taxdate = car.taxdate ?? Date()
      } /// onAppear

        }  /// VStack
        
        HStack {
            Spacer()
            Button("Submit") {
                DataController().editCar(car: car, make: make, model: model, regno: regno, purchasedate: purchasedate, mileagestarting: mileagestarting, purchasecost: purchasecost, regdate: regdate,  taxdate: taxdate, motdate: motdate, context: managedObjectContext)
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
