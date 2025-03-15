//
//  DataController.swift
//  Liftie Challenge
//
//  Created by Seth Barrios on 3/6/25.
//  Fucked with by Adam Loo on 3/8/25


import CoreData
import SwiftUI

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
            if lifts.isEmpty{
                clearDirtyLocations()
                // If there are no locations, insert predefined data
                addPredefinedLocations()
            }
            
        } catch {
            print("Error checking existing data: \(error)")
        }
    }

    // new struct just for this temporary initialization
    struct baseLocation{
        var name: String
        var xVal: Int
        var yVal: Int
    }
    
    // Insert predefined locations
    private func addPredefinedLocations() {
        let context = container.viewContext

        // New base starting data that includes button positions on the map
        // very static implementation. also felt like a dumbass writing Val over and over.
        let liftNameAndPositions = [
            baseLocation(name: "Thunder Quad Chair", xVal: 439, yVal: 298),
            baseLocation(name: "Sublette Quad Chair", xVal: 286, yVal: 164),
            baseLocation(name: "Moose Creek Quad Chair", xVal: 325, yVal: 617),
            baseLocation(name: "Union Pass Quad Chair", xVal: 444, yVal: 577),
            baseLocation(name: "Arial Tram", xVal: 539, yVal: 514),
            baseLocation(name: "Marmot Double Chair", xVal: 549, yVal: 310),
            baseLocation(name: "Bridger Gondola", xVal: 636, yVal: 457),
            baseLocation(name: "Sweetwater Gondola", xVal: 701, yVal: 497),
            baseLocation(name: "Casper Quad Chair", xVal: 733, yVal: 343),
            baseLocation(name: "Eagle's Rest Chair", xVal: 673, yVal: 610),
            baseLocation(name: "Teewinot Quad Chair", xVal: 758, yVal: 612),
            baseLocation(name: "Teton Quad Chair", xVal: 878, yVal: 346),
            baseLocation(name: "Apres Vous Quad Chair", xVal: 992, yVal: 448)
        ]

        for liftNameAndPosition in liftNameAndPositions {
            let newLift = LCLift(context: context)
            newLift.name = liftNameAndPosition.name
            newLift.xVal = liftNameAndPosition.xVal
            newLift.yVal = liftNameAndPosition.yVal
        }

        // Save context
        do {
            try context.save()
        } catch {
            print("Failed to save predefined data: \(error)")
        }
    }
    
    // This delets the LCLift objects from local storage
    // Needed becasue when updating from the string array to fuller baseLocation
    //  existing data was stopping a reset from happening on app start.
    private func clearDirtyLocations() {
        let context = container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = LCLift.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest) // Perform batch delete
            try context.save() // Save changes
            print("Successfully cleared all locations in MountainData.")
        } catch {
            print("Failed to clear locations: \(error)")
        }
    }
}
