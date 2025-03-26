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
            StartingIntroFlow()
            //MapLiftView() // Changed the starting target window group
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
