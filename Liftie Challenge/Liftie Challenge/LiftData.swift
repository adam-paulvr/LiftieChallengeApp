//
//  LiftData.swift
//  Liftie Challenge
//
//  Created by Adam Loo on 3/5/25.
//

import Foundation

struct Lift: Hashable {
    var liftName: String
    var hasBeenBeerd: Bool
    var hasEvidence: Bool //evidence is presence of a video or picture
    var evidence: String //string to eventually point to the video or picture TODO: figure out how to do this
}

class LiftData {
    static let lifts: [Lift] = [
        Lift(liftName: "Moose Creek Quad Chair", hasBeenBeerd: false, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Arial Tram", hasBeenBeerd: true, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Union Pass Quad Chair", hasBeenBeerd: false, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Sublette Quad Chair", hasBeenBeerd: true, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Thunder Quad Chair", hasBeenBeerd: false, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Marmot Double Chair", hasBeenBeerd: false, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Bridger Gondola", hasBeenBeerd: true, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Sweetwater Gondola", hasBeenBeerd: false, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Casper Quad Chair", hasBeenBeerd: false, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Teton Quad Chair", hasBeenBeerd: false, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Teewinot Quad Chair", hasBeenBeerd: false, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Apres vous Quad Chair", hasBeenBeerd: false, hasEvidence: false, evidence: "none"),
        Lift(liftName: "Eagle's Rest Chair", hasBeenBeerd: false, hasEvidence: false, evidence: "none")
    ]
}
