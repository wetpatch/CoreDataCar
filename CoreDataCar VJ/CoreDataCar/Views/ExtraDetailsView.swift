//
//  ExtraDetailsView.swift
//  CoreDataCar

import SwiftUI

struct ExtraDetailsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var car: FetchedResults<Car>.Element
    
    @State private var fueltype = ""
    @State private var enginesize = ""
    @State private var vin = ""
    @State private var version = ""
    @State private var colour = ""
    @State private var tyrepressure = ""
    @State private var oiltype = ""
    
    var body: some View {
        
        VStack   {
                Text("Extra Details")
                    .bold()
                    .foregroundColor(.blue)
                    .font(Font.custom("Avenir Heavy", size: 24))
                Text("\(car.make!) \(car.model!)")
                    .bold()
                    .foregroundColor(.black)
                    .font(Font.custom("Avenir Heavy", size: 24))

                    Section {
                        let columns = [GridItem(.fixed(175)), GridItem(.fixed(195))]
  LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 5 )  {
                            Text("      Fuel Type").gridCellColumns(1)
  TextField("Fuel Type", text: $fueltype).textFieldStyle(.roundedBorder)
                            Text("      Engine Size").gridCellColumns(1)
 TextField("Engine Size", text: $enginesize).textFieldStyle(.roundedBorder)

                            Text("      VIN No").gridCellColumns(1)
 TextField("VIN No", text: $vin).textFieldStyle(.roundedBorder)

                            Text("      Engine version").gridCellColumns(1)
 TextField("Engine version", text: $version).textFieldStyle(.roundedBorder)
                            Text("      Body Colour").gridCellColumns(1)
 TextField("Body Colour", text: $colour).textFieldStyle(.roundedBorder)

                        }   /// LazyGrid

          LazyVGrid(columns: columns, alignment: HorizontalAlignment.leading, spacing: 5 )  {
                            Text("      Tyre Pressure").gridCellColumns(1)
TextField("Tyre Pressure", text: $tyrepressure).textFieldStyle(.roundedBorder)
                            Text("      Oil Type").gridCellColumns(1)
TextField("Oil Type", text: $oiltype).textFieldStyle(.roundedBorder)

                                .onAppear {
                                    fueltype = car.fueltype ?? " "
                                    enginesize = car.enginesize ?? " "
                                    vin = car.vin ?? " "
                                    version = car.version ?? " "
                                    colour = car.colour ?? " "
                                    tyrepressure = car.tyrepressure ?? " "
                                    oiltype = car.oiltype ?? " "
                                    
                                } /// onAppear
                        }   /// LazyGrid
                   }  ///Section
            .font(.system(size: 14, weight: .bold))
            } /// VStack
            HStack {
                Spacer()
                Button("Submit") {
                    DataController().extraDetails(car: car, fueltype:  fueltype, enginesize: enginesize, vin: vin, version: version,  colour: colour, tyrepressure: tyrepressure, oiltype: oiltype,
                                                  context: managedObjectContext)
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
