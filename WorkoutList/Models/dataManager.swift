//
//  dataManager.swift
//  WorkoutList
//
//  Created by Jared Blanco on 5/1/22.
//

import Foundation

// loads from user dafaults, returns sampele movments if we have none though
func loadMovementList() -> [Movement]{
    var tempMovementList: [Movement] = []
    
    if let data = UserDefaults.standard.data(forKey: "movementList") {
        do {
            // Create JSON Decoder
            let decoder = JSONDecoder()

            // Decode Note
            tempMovementList = try decoder.decode([Movement].self, from: data)

        } catch {
            print("Unable to Decode Notes (\(error))")
        }
    }
    
    // if we don't have any data (ie user first install) we give them samples
    if(tempMovementList.isEmpty){
        tempMovementList = [Movement(name: "Sample Lift", sets: "3", reps: "12", weight: "0"),
                            Movement(name: "Add more movments above", sets: "1", reps: "1", weight: "0") ,
                            Movement(name: "Swipe to delete me", sets: "1", reps: "1", weight: "0"),
                            Movement(name: "Use the clear button to delete all", sets: "1", reps: "5", weight: "0"),
                            Movement(name: "Add from the workout loader tab", sets: "1", reps: "1", weight: "0")]
    }
    return tempMovementList
}



// loads from user dafaults, returns sampele workouts if we have none though
func loadWorkoutList() -> [WorkoutTemplate]{
    var tempWorkoutList: [WorkoutTemplate] = []
    
    if let data = UserDefaults.standard.data(forKey: "workoutList") {
        do {
            // Create JSON Decoder
            let decoder = JSONDecoder()

            // Decode Note
            tempWorkoutList = try decoder.decode([WorkoutTemplate].self, from: data)

        } catch {
            print("Unable to Decode Notes (\(error))")
        }
    }
    
    // if we don't have any data (ie user first install) we give them samples
    if(tempWorkoutList.isEmpty){
        tempWorkoutList = [
            WorkoutTemplate(name: "Arms", movements: [
                Movement(name: "DB Shoulder Press", sets: "3", reps: "8", weight: "0"),
                Movement(name: "Lateral raises", sets: "3", reps: "20", weight: "0"),
                Movement(name: "DB hammer curls", sets: "3", reps: "12", weight: "0"),
                Movement(name: "Barbell curls", sets: "3", reps: "12", weight: "0"),
                Movement(name: "Rope Tricep extensions", sets: "3", reps: "12", weight: "0"),
                Movement(name: "Skull Crushers", sets: "3", reps: "12", weight: "0")]),
            WorkoutTemplate(name: "Back", movements: [
                Movement(name: "Pull ups", sets: "3", reps: "12", weight: "0"),
                Movement(name: "Barbell Rows", sets: "3", reps: "12", weight: "0"),
                Movement(name: "Cable Seated Rows", sets: "3", reps: "12", weight: "0"),
                Movement(name: "Cable Reverse Flys", sets: "3", reps: "12", weight: "0"),
                Movement(name: "Reverse Grip Lat Pull Down", sets: "3", reps: "12", weight: "0"),
                Movement(name: "Dumbell Shrugs", sets: "3", reps: "12", weight: "0") ]),
            WorkoutTemplate(name: "Chest", movements: [
                Movement(name: "Barbell Bench Press", sets: "3", reps: "4", weight: "0"),
                Movement(name: "DB Incline Bench press",sets: "3", reps: "10", weight: "0"),
                Movement(name: "DB Flys",sets: "3", reps: "15", weight: "0"),
                Movement(name: "Weighted Dips",sets: "3", reps: "10", weight: "0")]),
            WorkoutTemplate(name: "Legs", movements: [
                Movement(name: "Squats", sets: "4", reps: "5", weight: "0"),
                Movement(name: "Deadlift", sets: "2", reps: "6", weight: "0"),
                Movement(name: "Leg Extension", sets: "3", reps: "15", weight: "0"),
                Movement(name: "Leg Curls", sets: "3", reps: "15", weight: "0"),
                Movement(name: "Calf Raises", sets: "3", reps: "10", weight: "0")])
        ]
    }
    return tempWorkoutList
}

func loadPastWorkouts()->[WorkoutTemplate]{
    var tempPastWorkoutList: [WorkoutTemplate] = []
    
    if let data = UserDefaults.standard.data(forKey: "pastWorkouts") {
        do {
            // Create JSON Decoder
            let decoder = JSONDecoder()

            // Decode Note
            tempPastWorkoutList = try decoder.decode([WorkoutTemplate].self, from: data)

        } catch {
            print("Unable to Decode Notes (\(error))")
        }
    }
    
    
    tempPastWorkoutList = [WorkoutTemplate(name: "Saturday, June 4, 2022", movements: [
        Movement(name: "Squats", sets: "4", reps: "5", weight: "225"),
        Movement(name: "Deadlift", sets: "2", reps: "6", weight: "275"),
        Movement(name: "Leg Extension", sets: "3", reps: "15", weight: "50"),
        Movement(name: "Leg Curls", sets: "3", reps: "15", weight: "50"),
        Movement(name: "Calf Raises", sets: "3", reps: "10", weight: "90")]),
    WorkoutTemplate(name: "Friday, June 3, 2022", movements: [
        Movement(name: "Pull ups", sets: "3", reps: "12", weight: "0"),
        Movement(name: "Barbell Rows", sets: "3", reps: "12", weight: "0"),
        Movement(name: "Cable Seated Rows", sets: "3", reps: "12", weight: "0"),
        Movement(name: "Cable Reverse Flys", sets: "3", reps: "12", weight: "0"),
        Movement(name: "Reverse Grip Lat Pull Down", sets: "3", reps: "12", weight: "0"),
        Movement(name: "Dumbell Shrugs", sets: "3", reps: "12", weight: "0") ]),
    WorkoutTemplate(name: "Thursday, June 2, 2022", movements: [
        Movement(name: "Barbell Bench Press", sets: "3", reps: "4", weight: "0"),
        Movement(name: "DB Incline Bench press",sets: "3", reps: "10", weight: "0"),
        Movement(name: "DB Flys",sets: "3", reps: "15", weight: "0"),
        Movement(name: "Weighted Dips",sets: "3", reps: "10", weight: "0")]),
    WorkoutTemplate(name: "Wednesday, June 1, 2022", movements: [
        Movement(name: "Squats", sets: "4", reps: "5", weight: "0"),
        Movement(name: "Deadlift", sets: "2", reps: "6", weight: "0"),
        Movement(name: "Leg Extension", sets: "3", reps: "15", weight: "0"),
        Movement(name: "Leg Curls", sets: "3", reps: "15", weight: "0"),
        Movement(name: "Calf Raises", sets: "3", reps: "10", weight: "0")])
    ]
    
    return tempPastWorkoutList
}

func savePastWorkouts(pastWorkouts: [WorkoutTemplate]){
    do{
        // Create JSON Encoder
        let encoder = JSONEncoder()

        // Encode Note
        let data = try encoder.encode(pastWorkouts)

        // Write/Set Data
        UserDefaults.standard.set(data, forKey: "pastWorkouts")
    } catch {
        print("unable to Encode Array of pastWorkouts (\(error))")
    }
}

func saveMovementList(movementList: [Movement]){
    do {
        // Create JSON Encoder
        let encoder = JSONEncoder()

        // Encode Note
        let data = try encoder.encode(movementList)

        // Write/Set Data
        UserDefaults.standard.set(data, forKey: "movementList")

    } catch {
        print("Unable to Encode Array of movements(\(error))")
    }
}

func saveWorkoutList(workoutList:[WorkoutTemplate] ){
    do {
        // Create JSON Encoder
        let encoder = JSONEncoder()

        // Encode Note
        let data = try encoder.encode(workoutList)

        // Write/Set Data
        UserDefaults.standard.set(data, forKey: "workoutList")

    } catch {
        print("Unable to Encode Array of workoutList (\(error))")
    }
}
