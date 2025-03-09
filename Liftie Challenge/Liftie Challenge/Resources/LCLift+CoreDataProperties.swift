//
//  LCLift+CoreDataProperties.swift
//  Liftie Challenge
//
//  Created by Seth Barrios on 3/6/25.
//
//

import Foundation
import CoreData


extension LCLift {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LCLift> {
        return NSFetchRequest<LCLift>(entityName: "LCLift")
    }

    @NSManaged public var name: String?
    @NSManaged public var beerd: Bool
    @NSManaged public var videoURL: String?
    @NSManaged public var pictureURL: String?
    @NSManaged public var xVal: Int // Added to remeber button placement on map
    @NSManaged public var yVal: Int // Super brittle and need to better implement for full app

}

extension LCLift : Identifiable {

}
