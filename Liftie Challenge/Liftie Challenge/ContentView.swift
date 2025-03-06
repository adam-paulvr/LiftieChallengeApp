//
//  ContentView.swift
//  Liftie Challenge
//
//  Created by Adam Loo on 3/5/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(LiftData.lifts, id: \.self) {lift in
                HStack{
                    Text("\(lift.liftName)")
                        .frame(maxWidth: .infinity, alignment: .leading)
                    if(!lift.hasBeenBeerd){
                        NavigationLink("Not Beerd", value: lift)
                            .frame(width: 100, alignment: .trailing)
                    }
                    else
                    {
                        NavigationLink("Beerd", value: lift)
                            .frame(width: 100, alignment: .trailing)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(lift.hasBeenBeerd ? Color.green : Color.fromRGB(255, 144, 179))
            }
            .navigationTitle("Chairs")
            .navigationDestination(for: Lift.self){ lift in
                Text(lift.liftName)
                if(lift.hasBeenBeerd){
                    Text("Chair has been Beerd")
                }else{
                    Text("Chair has not been Beerd")
                }
            }
        }
    }
}

extension Color {
    static func fromRGB(_ red: Int, _ green: Int, _ blue: Int) -> Color {
        return Color(red: Double(red) / 255.0,
                     green: Double(green) / 255.0,
                     blue: Double(blue) / 255.0)
    }
}

#Preview {
    ContentView()
}
