//
//  MainCarView.swift
//  CoreDataCar
//
//  Created by Chris Milne on 20/09/2023.

//

import SwiftUI

struct MainCarView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    //   @Environment(\.presentationMode) var presentationMode // Add this line
    
    @State private var showingEditView = false
    @State private var showingAddView = false
    @State private var showingExtraView = false
    @State private var showingInsurance = false
    @State private var showingExpense = false
    @State private var tabIndex: Int? = nil
    
    let tabBarDataList = [
        tabBarData(lable: "Edit", img: "square.and.pencil"),
        tabBarData(lable: "Fuel", img: "fuelpump.circle"),
        tabBarData(lable: "Extra", img: "list.bullet"),
        tabBarData(lable: "Insurance", img: "cross.vial"),
        tabBarData(lable: "Expenses", img: "sterlingsign.circle")
    ]
    
    var car: FetchedResults<Car>.Element
    
    
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
        //      NavigationView {
        VStack {
            Text("Main View")
                .bold()
                .foregroundColor(.blue)
                .font(Font.custom("Avenir Heavy", size: 24))

//       MARK: Work out Cost per Day and Month
            let daysDiff = Dates.dateDiff(firstdate: car.purchasedate ?? Date())
            let costperDay: Double = (car.fuelcosttot) / Double(daysDiff )
            let columns = [GridItem(.fixed(175)), GridItem(.fixed(180))]
            VStack (alignment: .leading, spacing: 8) {
                List {
             //       let columns = [GridItem(.fixed(175)), GridItem(.fixed(180))]
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 10 )      {
                        
                        Text("   Make/Model").gridCellColumns(1)
                        Text("\(car.make!) \(car.model!)")

                        Text("   Reg Number: ").gridCellColumns(1)
                        Text("\(car.regno ?? "")")

                        Text("   Registered Date").gridCellColumns(1)
                        Text(Dates.aString(date: car.regdate ?? Date()))

                        Text("   Starting Mileage").gridCellColumns(1)
                        Text("\(car.mileagestarting)")

                        Text("   Purchase Cost").gridCellColumns(1)
                        Text("£ " + String(format: "%.0f", car.purchasecost))

                        
                    }  /// LazyGrid
                    let average = Double(car.mileagenow - car.mileagestarting) / (car .litrestot / 4.536)
                    
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 8)      {
                        Text("   Purchase Date").gridCellColumns(1)
                        Text(Dates.aString(date: car.purchasedate ?? Date()))
                        Text("   Tax Date").gridCellColumns(1)
                        Text(Dates.aString(date: car.taxdate ?? Date()))
                        Text("   MOT Date").gridCellColumns(1)
                        Text(Dates.aString(date: car.motdate ?? Date()))
                        Text("   Insurance Renewal").gridCellColumns(1)
                        Text(Dates.aString(date: car.insurancedate ?? Date()))
                        Text("   Average MPG").gridCellColumns(1);
                        Text(String(format: "%.1f", average))
                    }/// LazyGrid
                    LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 8 )      {
                        Text("   Tot Fuel Cost").gridCellColumns(1);
                        Text("£ " + String(format: "%.0f", car.fuelcosttot))
                        Text("   Tot Insurance").gridCellColumns(1);
                        Text("£ \( car.insurancecosttot)")
                        Text("   Tot Expenses").gridCellColumns(1)
                        Text("£ " + String(format: "%.0f", car.expensestot))
                        Text("   Fuel Cost Daily").gridCellColumns(1)
                        Text("£ " + String(format: "%.2f", costperDay))
                        Text("   Fuel Cost Monthly").gridCellColumns(1)
                        Text("£ " + String(format: "%.0f", costperDay*30))
                    } /// LazyGrid
                }  /// VStack
            } // List
            
            
            Divider()
            HStack(alignment: .center) {
                ForEach(0 ..< 5) {
                    idx in
                    Spacer()
                    Button {
                        tabIndex = idx
                    } label: {
                        VStack(alignment: .center) {
                            
                            Image(systemName: tabBarDataList[idx].img).font(.system(size: 20, weight: .bold)).frame(width: 24, height: 24)
                                .padding(.top, 8)
                            
                            Text(tabBarDataList[idx].lable).font(.caption2)
                                .frame(width: 65)
                            //                         .multilineTextAlignment(.center)
                        } ///VStack
                        .frame(width: 30).foregroundColor(tabIndex == idx ? Color.purple : .gray)
                        .padding(.bottom, -12)
                        .animation(.easeOut, value: tabIndex)
                    } /// Label
                    
                    /*
                     'init(_:destination:tag:selection:)' was deprecated in iOS 16.0: use NavigationLink(value:label:), or navigationDestination(isPresented:destination:), inside a NavigationStack or NavigationSplitView
                     */
                    Spacer()
                    
                    NavigationLink("",destination: EditCarView(car: car), tag: 0, selection: $tabIndex)
                    NavigationLink("",destination: AddFuel(car: car), tag: 1, selection: $tabIndex)
                    NavigationLink("",destination: ExtraDetailsView(car: car), tag: 2, selection: $tabIndex)
                    NavigationLink("",destination: AddInsurance(car: car), tag: 3, selection: $tabIndex)
                    NavigationLink("",destination: AddExpense(car: car), tag: 4, selection: $tabIndex)
                    
                } /// For Each
                
            } /// HStack
            .background(.thinMaterial)
            .ignoresSafeArea(.all)
        }
    } /// Body
} /// Struct


struct tabBarData: Identifiable {
    var id = UUID()
    var lable: String
    var img: String
}
//
