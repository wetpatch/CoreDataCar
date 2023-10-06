//
//  ContentView.swift
//  CoreDataCar
//
//  Created by Chris Milne on 26/09/2023.
//

import SwiftUI

struct ContentView: View {
    
    let buttonWidth = Size.screenWidth/1.3
    let buttonHeight = Size.screenHeight/5
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Vehicle Efficiency")
                    .foregroundColor(Color.teal)
                    .font(.system(size: 36, weight: .bold))
                    .padding()
                ZStack {
                    HStack {
                        Text("Build up details of your vehicle. \nIt shows all relevant dates for: \n Tax renewal \n MOT renewal \n Insurance renewal \n  Plus details of all your expenses. \n And all fuel expenditure \n See your MPG and Daily/Monthly fuel costs.")
                            .font(.system(size: 16, weight: .bold))
                            .multilineTextAlignment(.center)
                            .frame(minWidth: 0, maxWidth: 380, minHeight: 0, maxHeight: 300)
                    }
                }
                NavigationLink(destination: ListView()
                    .navigationBarBackButtonHidden(true)
                ) {
                    CustomButton(label: "Continue", width: 300)
                        .padding()
                }  /// CustomButton
//                .simultaneousGesture(TapGesture().onEnded {
//                })  // Simultaneous Gesture
                
            }  // VStack
//            .animation(.spring(), value: 1)
        } /// NavigationView
    } /// Body
}  /// Struct

#Preview {
    ContentView()
}
