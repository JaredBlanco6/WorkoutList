//
//  WorkoutTemplate.swift
//  WorkoutList
//
//  Created by Jared Blanco on 4/14/22.
//

import Foundation
import SwiftUI

// a movement example if bench, squats, ect
struct Movement: Hashable, Codable {
    var name : String
    var sets: String
    var reps: String
    var weight: String
}

// a workout has a name and a list of movments
struct WorkoutTemplate: Hashable, Codable{
    var name : String
    var movements: [Movement]
}





