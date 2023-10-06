//
//  Dates.swift
//  CoreDataCar
//
//  Created by Chris Milne on 30/07/2023.
//

import SwiftUI

struct Dates: DatePickerStyle {
    var dateString: Binding<String>

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Change the date format to match your desired format
        return formatter
    }()   /// Static Let

    func makeBody(configuration: Configuration) -> some View {
        TextField("Enter date", text: dateString, onEditingChanged: { editing in
            if !editing, let newDate = Self.dateFormatter.date(from: dateString.wrappedValue) {
                configuration.selection = newDate
            } /// IF
        })   /// TextField
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onAppear {
            dateString.wrappedValue = Self.dateFormatter.string(from: configuration.selection)
        } /// On Appear
    }  /// Func
  
    static func dateDiff(firstdate: Date) -> Int {
        let calendar = Calendar.current
        let ToDate = Date()
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: firstdate)
        let date2 = calendar.startOfDay(for: ToDate)
        let components = calendar.dateComponents([Calendar.Component.day], from: date1, to: date2)
        // This will return the number of day(s) between dates
        let daysDiff = Int(components.day!)
        return daysDiff
    }
    
    static func aString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let strDate = formatter.string(from: date)
        return strDate
    }
    
    
    
}  /// Struct


