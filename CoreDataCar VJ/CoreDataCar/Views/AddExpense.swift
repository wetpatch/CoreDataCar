//
//  AddExpense.swift
//  CoreDataCar
//
//  Created by Chris Milne on 03/09/2023.
//
//
import SwiftUI
import CoreData

struct AddExpense: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    
    @StateObject var car: Car
    @State private var regnum = ""
    @State private var expensedetail: String = ""
    @State private var expensecost:Double = 0.0
    @State private var expensedate = Date()
    
    @State private var expensedateString = ""
    @State private var selectedDate = Date()
    @State var detail: String = ""
    @State var cost: Double = 0.0
    @State var expensetot: Double = 0.0
    @State private var isEditing = false

    
    var body: some View {
        
        Text("Add Expense")
            .bold()
            .foregroundColor(.blue)
            .font(Font.custom("Avenir Heavy", size: 20))
        Text("\(car.make!) \(car.model!) \(car.regno!)")
            .bold()
            .foregroundColor(.black)
            .font(Font.custom("Avenir Heavy", size: 20))
        
        Form {
            Section {
                let columns = [GridItem(.fixed(120)), GridItem(.fixed(175))]
                LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 5) {
                    Text(" Expense Date")
                    DatePicker("   Expense Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(Dates(dateString: $expensedateString))
                        
                        .onChange(of: selectedDate) { newDate in
                            expensedateString = Dates.dateFormatter.string(from: newDate)
                        }  /// NewDate
                    
                    Text(" Detail")
                    TextField("Detail", text: $detail)
                        .textFieldStyle(.roundedBorder).gridCellColumns(1)
                    Text(" Cost                     £")
                    TextField(" Cost", value: $cost, format: .number)
                        .textFieldStyle(.roundedBorder)
                    Spacer()
                    Button(action: updateFile) {
                        Label("Press PLUS to Update  ", systemImage: "plus.circle").labelStyle(.titleAndIcon)
                            .frame(width: 300, height: 44, alignment: .leading)
                    } /// Button
                    .buttonStyle(.automatic)
                }   /// LazyGrid
            }   /// Section
        } /// Form
        .font(.system(size: 14, weight: .bold))
        
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    let rows = [GridItem(.adaptive(minimum: 200))]
                    ForEach(car.carExpenseArray) { expense in
                        LazyHGrid(rows: rows, spacing: 10 )      {
                                Text(Dates.aString(date: expense.expensedate ?? Date()))
                                Text("£ " + String(format: "%.2f", expense.expensecost))
                                Text(expense.expensedetail ?? "")
                        }   /// LazyHGrid
                    }.onDelete(perform: deleteExpense)      /// For Each
                } /// List
                .font(.system(size: 14, weight: .semibold))
                Text("      Total Expenses: £ " + String(format: "%.2f", car.carExpenseArray.reduce(0.0)
                    { $0 + ($1.expensecost) }))
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
        

        Button("Return")
        {
            dismiss()
        }                                   ///Button
        .padding([.bottom, .leading], 20)
        .buttonStyle(.borderedProminent)
    } /// Body
    
    private func deleteExpense(offsets: IndexSet) {
        withAnimation {
            offsets.map { car.carExpenseArray[$0] }
                .forEach { expense in
                    car.removeFromCarExpense(expense)
                }
            DataController().save(context: managedObjectContext)
        } /// func
    } /// Animation
    
    
    
    private func updateFile() {
        withAnimation {
            let newExpense = Expense(context: managedObjectContext)
            newExpense.expensedetail = detail
            newExpense.expensecost = Double(cost)
            newExpense.expensedate = selectedDate
            
            car.addToCarExpense(newExpense)
            DataController().save(context: managedObjectContext)
            updateTotExpense()
        }
    }
    private func updateTotExpense() {
        /* The reduce function is used to iterate through car.expensesArray and calculate the total expenses. The initial value is 0.0, and for each expense ($1), the expensecost is added to the accumulator ($0).
         The nil coalescing operator (??) is used to handle the case where expensecost might be nil (optional), ensuring that it's treated as 0.0 in the calculation.
         
         After running this code, the total expenses will be stored in car.expensestot. This property will be updated whenever the expenses in car.expensesArray change, ensuring that it always reflects the correct total.
         */
        car.expensestot = car.carExpenseArray.reduce(0.0) { $0 + ($1.expensecost ) }
        DataController().save(context: managedObjectContext)
    } /// func
} /// struct







