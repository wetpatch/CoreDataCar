//  EditCarView.swift


import SwiftUI

struct EditCarView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var car: FetchedResults<Car>.Element
    
//    @Binding var showingEditView: Bool

    @State private var make = ""
    @State private var model = ""
    @State private var regno = ""
    @State private var purchasedate = Date()
    @State private var regdate = Date()
    @State private var motdate = Date()
    @State private var taxdate = Date()
    @State private var insurancedate = Date()
    
    @State private var mileagestarting:Int64  = 0
    @State private var purchasecost:Double = 0.0
    @State private var purchasedateString = ""
    @State private var regdateString = ""
    @State private var motdateString = ""
    @State private var taxdateString = ""
    @State private var insurancedateString = ""
    
    var body: some View {
        
        VStack   {

                Text("Edit Main Details")
                    .bold()
                    .foregroundColor(.blue)
                    .font(Font.custom("Avenir Heavy", size: 24))
            Form {
                Section {
                    let columns = [GridItem(.fixed(175)), GridItem(.fixed(175))]
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )  {
                        Text("   Car Make").gridCellColumns(1)
                        TextField("Car Make", text: $make).textFieldStyle(.roundedBorder)
                        Text("   Car Model").gridCellColumns(1)
                        TextField("Car Model", text: $model).textFieldStyle(.roundedBorder)
                        Text("   Reg Number").gridCellColumns(1)
                        TextField("Reg No", text: $regno).textFieldStyle(.roundedBorder)
                        Text("   Starting Mileage").gridCellColumns(1)
                        TextField("Starting Mileage", value: $mileagestarting, format: .number).textFieldStyle(.roundedBorder)
                        Text("   Purchase Cost £").gridCellColumns(1)
                        TextField("Purchase Cost", value: $purchasecost, format: .number).textFieldStyle(.roundedBorder)
                    }   /// LazyGrid
                    
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )  {
                        
                        Text("   Purchase Cost £").gridCellColumns(1)
                        TextField("Purchase Cost", value: $purchasecost, format: .number).textFieldStyle(.roundedBorder)
                        Text("   Purchase Date").gridCellColumns(1)
                        DatePicker("Purchase Date", selection: $purchasedate, displayedComponents: .date)
                            .datePickerStyle(Dates(dateString: $purchasedateString))
                            
                            .onChange(of: purchasedate) { newDate in
                                purchasedateString = Dates.dateFormatter.string(from: newDate)
                            }  /// NewDate
                        Text("   Registration Date").gridCellColumns(1)
                        DatePicker("Reg Date", selection: $regdate, displayedComponents: .date)
                            .datePickerStyle(Dates(dateString: $regdateString))
                            
                            .onChange(of: regdate) { newDate in
                                regdateString = Dates.dateFormatter.string(from: newDate)
                            }  /// NewDate
                        Text("   TAX Date").gridCellColumns(1)
                        DatePicker("Tax Date", selection: $taxdate, displayedComponents: .date)
                            .datePickerStyle(Dates(dateString: $taxdateString))
                            
                            .onChange(of: taxdate) { newDate in
                                taxdateString = Dates.dateFormatter.string(from: newDate)
                            }  /// NewDate
                        Text("   MOT Date").gridCellColumns(1)
                        DatePicker("MOT Date", selection: $motdate, displayedComponents: .date)
                            .datePickerStyle(Dates(dateString: $motdateString))
                            
                            .onChange(of: motdate) { newDate in
                                motdateString = Dates.dateFormatter.string(from: newDate)
                            }  /// NewDate

                        Text("   Renewal Date").gridCellColumns(1)
                        DatePicker("Insurance Date", selection: $insurancedate, displayedComponents: .date)
                            .datePickerStyle(Dates(dateString: $insurancedateString))
                            
                            .onChange(of: insurancedate) { newDate in
                                insurancedateString = Dates.dateFormatter.string(from: newDate)
                            }  /// NewDate
 
 
                    }  /// LazyGrid
                } /// Section
            } /// Form
            .font(.system(size: 14, weight: .bold))
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
          insurancedate = car.insurancedate ?? Date()
          
      } /// onAppear

        }  /// VStack
        
        HStack {
            Spacer()
            Button("Submit") {
                DataController().editCar(car: car, make: make, model: model, regno: regno, purchasedate: purchasedate, mileagestarting: mileagestarting, purchasecost: purchasecost, regdate: regdate,  taxdate: taxdate, motdate: motdate, insurancedate: insurancedate, context: managedObjectContext)
                dismiss()
            } ///Button
              .buttonStyle(.borderedProminent)
            Spacer()
            Button("Exit") {
                dismiss()
            } ///Button
            .buttonStyle(.borderedProminent)
            Spacer()
            
        } /// Hstack
    } /// Body
} /// struct
