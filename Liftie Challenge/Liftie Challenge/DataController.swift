//
//  DataController.swift
//  Liftie Challenge
//
//  Created by Seth Barrios on 3/6/25.
//


import CoreData
import UIKit

class DataController: ObservableObject {
    static let shared = DataController() // Singleton pattern
    
    // Core Data stack
    private init() { }
    
    // Context to interact with Core Data
    var container: NSPersistentContainer!

    func loadPersistentStores() {
        container = NSPersistentContainer(name: "Model") // Name of the .xcdatamodeld file
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            } else {
                self.insertInitialDataIfNeeded()
            }
        }
    }
    
    // Insert predefined data if needed
    private func insertInitialDataIfNeeded() {
        let context = container.viewContext
        
        let fetchRequest: NSFetchRequest<LCLift> = LCLift.fetchRequest()
        
        do {
            let locations = try context.fetch(fetchRequest)
            if locations.isEmpty {
                // If there are no locations, insert predefined data
                addPredefinedLocations()
            }
        } catch {
            print("Error checking existing data: \(error)")
        }
    }

    // Insert predefined locations
    private func addPredefinedLocations() {
        let context = container.viewContext
        
        let lift1 = LCLift(context: context)
        lift1.name = "Lift 1"
        
//        let location1 = Location(context: context)
//        location1.name = "Paris"
//        location1.latitude = 48.8566
//        location1.longitude = 2.3522
//        
//        let location2 = Location(context: context)
//        location2.name = "New York"
//        location2.latitude = 40.7128
//        location2.longitude = -74.0060
//        
//        let location3 = Location(context: context)
//        location3.name = "Tokyo"
//        location3.latitude = 35.6762
//        location3.longitude = 139.6503
        
        // Add more locations if needed...

        // Save context
        do {
            try context.save()
        } catch {
            print("Failed to save predefined data: \(error)")
        }
    }
}
