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
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Change the date format to match your desired format
        return formatter
    }()
    
    
    var body: some View {
        
        Text("Add Expense")
            .bold()
            .foregroundColor(.blue)
            .font(Font.custom("Avenir Heavy", size: 20))
        Text("\(car.make!) \(car.model!) \(car.regno!)")
            .bold()
            .foregroundColor(.red)
            .font(Font.custom("Avenir Heavy", size: 20))
        
        //       HStack {
        Form {
            Section {
                let columns = [GridItem(.fixed(120)), GridItem(.fixed(175))]
                LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 5) {
                    Text(" Expense Date").font(.system(size: 14, weight: .bold))
                    DatePicker("   Expense Date", selection: $selectedDate, displayedComponents: .date)
                        .datePickerStyle(TextDatePickerStyle(dateString: $expensedateString))
                        .gridCellColumns(2)
                        .onChange(of: selectedDate) { newDate in
                            expensedateString = dateFormatter.string(from: newDate)
                        }  /// NewDate
                    
                    Text(" Detail").font(.system(size: 14, weight: .bold))
                    TextField("Detail", text: $detail)
                        .font(.system(size: 14, weight: .bold))
                        .textFieldStyle(.roundedBorder).gridCellColumns(1)
                    Text(" Cost").font(.system(size: 14, weight: .bold))
                    TextField(" Cost", value: $cost, format: .number)
                        .font(.system(size: 14, weight: .bold))
                        .textFieldStyle(.roundedBorder).gridCellColumns(2)
                    Spacer()
                    Button(action: addExpense) {
                        Label("Add", systemImage: "plus").labelStyle(.titleOnly)
                            .frame(width: 44, height: 44, alignment: .center)
                            .padding([.bottom, .leading], 10) 
                    } /// Button
                }   /// LazyGrid
            }   /// Section
        } /// Form

        
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(car.expensesArray) { expense in
                        NavigationLink(
                            destination: MainCarView(car: car)
                        )  {
                                Text(DataController.aString(date: expense.expensedate ?? Date()))
                                    .font(.system(size: 14, weight: .light))
                                Text(expense.expensedetail ?? "")
                                    .font(.system(size: 14, weight: .light))
                                Text("£ " + String(format: "%.0f", expense.expensecost))
                                    .font(.system(size: 14, weight: .light))
                        }   /// NavLink

                    }.onDelete(perform: deleteExpense)      /// For Each
                } /// List
                Text("                      Total Expenses: £ " + String(format: "%.0f", car.expensesArray.reduce(0.0)
                    { $0 + ($1.expensecost) }))
                .font(.system(size: 14, weight: .light))
                
            } /// VStack


            
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()   /// Displays an Edit button
                } /// ToolbarItem
            } /// ToolBar
            .sheet(isPresented: $isEditing) {
                ListView()
                
            } /// sheet
        } /// Nav View
        .navigationViewStyle(.stack)
        
        //              HStack {
        Button("Exit")
        {
            dismiss()
        }                                   ///Button
        .padding([.bottom, .leading], 20)  /// HStack
        
    } /// Body
    
    private func deleteExpense(offsets: IndexSet) {
        withAnimation {
            offsets.map { car.expensesArray[$0] }
                .forEach { expense in
                    managedObjectContext.delete(expense)
                }
            DataController().save(context: managedObjectContext)
        } /// func
    } /// Animation
    
    
    
    private func addExpense() {
        withAnimation {
            let newExpense = Expense(context: managedObjectContext)
            newExpense.expensedetail = detail
            newExpense.expensecost = Double(cost)
            newExpense.expensedate = selectedDate
            
            car.addToExpenses(newExpense)
            DataController().save(context: managedObjectContext)
            updateTotExpense()
        }
    }
    private func updateTotExpense() {
        /* The reduce function is used to iterate through car.expensesArray and calculate the total expenses. The initial value is 0.0, and for each expense ($1), the expensecost is added to the accumulator ($0).
         The nil coalescing operator (??) is used to handle the case where expensecost might be nil (optional), ensuring that it's treated as 0.0 in the calculation.
         
         After running this code, the total expenses will be stored in car.expensestot. This property will be updated whenever the expenses in car.expensesArray change, ensuring that it always reflects the correct total.
         */
        car.expensestot = car.expensesArray.reduce(0.0) { $0 + ($1.expensecost ) }
        DataController().save(context: managedObjectContext)
    }
    
    
}
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
 /*
        ScrollView {
            let columns = [GridItem(.fixed(80)), GridItem(.fixed(175)), GridItem(.fixed(60))]
            LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )  {

                    ForEach(car.expensesArray) { expense in

                        Text(DataController.aString(date: expense.expensedate ?? Date()))
                            .font(.system(size: 12, weight: .light))
                            .gridCellColumns(1)
                        
                        Text(expense.expensedetail ?? "")
                            .font(.system(size: 12, weight: .light))
                            .gridCellColumns(2)
                        
                        Text("£ " + String(format: "%.0f", expense.expensecost))
                            .font(.system(size: 12, weight: .light))
                            .gridCellColumns(3)

                    }.onDelete(perform: deleteExpense)   /// ForEACH
                } /// LaztGrid
            } /// ScrollView
*/

/*
    func deleteExpense(at offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let expense = Expense(context: managedObjectContext)
    //            car.deleteExpense(expense)
      //          context.delete(expense)
                DataController().deleteExpense(context: managedObjectContext, expense: expense)
                
            }
        }
    }
 */



