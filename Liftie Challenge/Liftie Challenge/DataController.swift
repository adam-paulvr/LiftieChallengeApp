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
        container = NSPersistentContainer(name: "MountainData") // Name of the .xcdatamodeld file
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
            let lifts = try context.fetch(fetchRequest)
            if lifts.isEmpty {
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
        
        let liftNames = [
            "Moose Creek Quad Chair",
            "Arial Tram",
            "Union Pass Quad Chair",
            "Sublette Quad Chair",
            "Thunder Quad Chair",
            "Marmot Double Chair",
            "Bridger Gondola",
            "Sweetwater Gondola",
            "Casper Quad Chair",
            "Teton Quad Chair",
            "Teewinot Quad Chair",
            "Apres vous Quad Chair",
            "Eagle's Rest Chair"
        ]

        
        for liftName in liftNames {
            let newLift = LCLift(context: context)
            newLift.name = liftName
        }

        // Save context
        do {
            try context.save()
        } catch {
            print("Failed to save predefined data: \(error)")
        }
    }
}
