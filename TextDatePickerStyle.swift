//
//  TextDatePickerStyle.swift
//  CoreDataCar
//
//  Created by Chris Milne on 30/07/2023.
//

import SwiftUI

struct TextDatePickerStyle: DatePickerStyle {
    var dateString: Binding<String>

    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy" // Change the date format to match your desired format
        return formatter
    }()

    func makeBody(configuration: Configuration) -> some View {
        TextField("Enter date", text: dateString, onEditingChanged: { editing in
            if !editing, let newDate = Self.dateFormatter.date(from: dateString.wrappedValue) {
                configuration.selection = newDate
            }
        })
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onAppear {
            dateString.wrappedValue = Self.dateFormatter.string(from: configuration.selection)
        }
    }
}


