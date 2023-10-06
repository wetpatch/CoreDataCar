//
//  CoreDataCarApp.swift
//  CoreDataCar
//
//  Created by Chris Milne on 22/06/2023.
//

import SwiftUI

@main
struct CoreDataCarApp: App {
    @StateObject private var dataController = DataController()

    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
