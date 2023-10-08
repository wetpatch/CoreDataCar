//
//  AddInsurance.swift
//  CoreDataCar
//
//  Created by Chris Milne on 04/10/2023.
//

import SwiftUI
import CoreData

struct AddInsurance: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
//    var car: FetchedResults<Car>.Element
    @StateObject var car: Car
    
    @State private var insdate: Date = Date()      /// Insurance Entity
    @State private var cost: Int64 = 0             /// Insurance Entity
    @State private var comment: String = ""        /// Insurance Entity

    @State private var insurerpolicy: String = ""  /// Car Entity
    @State private var insurername: String = ""    /// Car Entity
    @State private var insurercontact: String = "" /// Car Entity
    
    @State private var insurancedateString = ""    /// Temp variables
    @State private var selectedDate = Date()       /// Temp variables
    @State var tempdate = Date()                   /// Temp variables
    @State var tempcost: Int64  = 0                /// Temp variables
    @State var tempcomment: String = ""            /// Temp variables
    @State var temppolicy: String = ""             /// Temp variables
    @State var tempname: String = ""               /// Temp variables
    @State var tempcontact: String = ""             /// Temp variables
    
    @State private var isEditing = false

    
    var body: some View {
        
        Text("Update Insurance")
            .bold()
            .foregroundColor(.blue)
            .font(Font.custom("Avenir Heavy", size: 20))
        
        Form {
            Section {
                let columns = [GridItem(.fixed(120)), GridItem(.fixed(175))]
                LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10) {

                    Text(" ")
                    Text(" ").gridCellColumns(1)
                    Text(" Insurer Name")
                    TextField("Name", text: $tempname).gridCellColumns(1)
                    Text(" Policy No")
                    TextField("PolicyNo", text: $temppolicy).gridCellColumns(1)
                    Text(" Contact")
                    TextField("Contact", text: $tempcontact).gridCellColumns(1)
                    Text(" Date")
                    DatePicker("   Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(Dates(dateString: $insurancedateString))
                        .onChange(of: selectedDate) { newDate in
                            insurancedateString = Dates.dateFormatter.string(from: newDate)
                        }  /// NewDate
                    Text(" Premium £")
                    TextField("Premium", value: $tempcost, format: .number).gridCellColumns(1)
                    Text(" Comment")
                    TextField("Comment", text: $tempcomment).gridCellColumns(1)
                    Spacer()
                    Button(action: addInsurance) {
                        Label("Press PLUS to Update", systemImage: "plus.circle").labelStyle(.titleAndIcon)
                            .frame(width: 300, height: 44, alignment: .leading)
                    } /// Button
                }   /// LazyGrid
            }   /// Section
        } /// Form
       .font(.system(size: 14, weight: .semibold))
        
        .onAppear {
            tempname = car.insurername ?? " "
            temppolicy = car.insurerpolicy ?? " "
           tempcontact = car.insurercontact ?? " "
        }
        
       NavigationView {
           VStack(alignment: .leading) {

               List {
                    let rows = [GridItem(.adaptive(minimum: 180))]

                       ForEach(car.carInsuranceArray) { insurance in
                           LazyHGrid(rows: rows, spacing: 10 )      {
                           Text(Dates.aString(date: insurance.insdate ?? Date()))
                               Text("£ \(insurance.cost )")
                           Text(insurance.comment ?? " ")
                           } /// LazyGrid
                           }.onDelete(perform: deleteInsurance)      /// For Each
                }   /// List
                .font(.system(size: 14, weight: .semibold))
/*
            Text("      Total Premiums £ " + String(format: "%.0f", car.carInsuranceArray.reduce(0)
                    { $0 + ($1.cost) }))
 */
               Text("      Total Premiums £ \(car.insurancecosttot)")
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
        }   
        .buttonStyle(.borderedProminent)    ///Button
        .padding([.bottom, .leading], 20)
        
    } /// Body
    
    private func deleteInsurance(offsets: IndexSet) {
        withAnimation {
            offsets.map { car.carInsuranceArray[$0] }
                .forEach { insurance in
                    car.removeFromCarInsurance(insurance)
                } /// ForEach
                    DataController().save(context: managedObjectContext)
        } /// Animation
    } /// func

    private func addInsurance() {
        withAnimation {
            let newInsurance = Insurance(context: managedObjectContext)
            newInsurance.insdate = selectedDate
            newInsurance.cost = Int64(tempcost)
            newInsurance.comment = tempcomment
            car.addToCarInsurance(newInsurance)
            DataController().save(context: managedObjectContext)
            updateTotInsurance()
        }
    }

    private func updateTotInsurance() {
        /* The reduce function is used to iterate through car.expensesArray and calculate the total fuel cost. The initial value is 0.0, and for each fuelcost ($1), the fuelcost is added to the accumulator ($0).
         The nil coalescing operator (??) is used to handle the case where fuelcost might be nil (optional), ensuring that it's treated as 0.0 in the calculation.
         
         After running this code, the total fuelcost will be stored in car.fuelcosttot. This property will be updated whenever the fuelcost in car.fuelArray change, ensuring that it always reflects the correct total.
         */
        car.insurancecosttot = car.carInsuranceArray.reduce(0) { $0 + ($1.cost ) }
        car.insurername = tempname
        car.insurerpolicy = temppolicy
        car.insurercontact = tempcontact
        DataController().save(context: managedObjectContext)
    }
    
    
}
