//
//  Liftie_ChallengeApp.swift
//  Liftie Challenge
//
//  Created by Adam Loo on 3/5/25.
//

import SwiftUI

@main
struct Liftie_ChallengeApp: App {
    
    let dataController = DataController.shared
    
    init() {
        dataController.loadPersistentStores()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
