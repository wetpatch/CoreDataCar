//  ListView.swift


import SwiftUI
import CoreData

struct ListView: View {
    @Environment(\.managedObjectContext) var managedObjContext
    @Environment(\.dismiss) var dismiss
    
    /// Get the data. Use the date variable as an array and list in reverse order
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.purchasedate, order: .reverse)]) var car:
    FetchedResults<Car>
   @FetchRequest(sortDescriptors: [SortDescriptor(\.expensedate, order: .reverse)]) var expense:
   FetchedResults<Expense>
    
    @State private var showingAddView = false
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                List {                            /// WE have an UUID so do not need an initial value in the For Next Loop
                    ForEach(car) { car in
                        NavigationLink(
                            destination: MainCarView(car: car)
                        ) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    if car.make != nil  {
                                        Text("\(car.make ?? "")") + Text(" \(car.model ?? "")") + Text("  \(car.regno ?? "")")
                                            .bold()
                                            .foregroundColor(.red)
                                        Spacer()
                                    } /// If
                                    else {
                                        Text("Empty Record")
                                    } /// else
                                } ///VStack
                            } /// HStack
                        } /// Nav Link
                    } /// For Each
                    .onDelete(perform: deleteCar)
                } /// List
                .listStyle(.plain)
            } /// VStack
            
            
            .navigationTitle("All Vehicles")
            .toolbar {
                
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Car",  systemImage: "plus.circle")
                        Text("Add")
                    } /// Label
                }  /// ToolbarItem
                
                
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()   /// Displays an Edit button
                } /// ToolbarItem
            } /// ToolBar
            .sheet(isPresented: $showingAddView) {
                AddCarView()
                
                
            } /// sheet
        } /// Nav View
        .navigationViewStyle(.stack)
        
    } /// Body View
    
    private func deleteCar(offsets: IndexSet)  {
        withAnimation {                          /// Need to map the Database to the current position with [$0]
            offsets.map { car[$0] }
                .forEach(managedObjContext.delete)
            DataController().save(context: managedObjContext)
        }
    }
}
struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
