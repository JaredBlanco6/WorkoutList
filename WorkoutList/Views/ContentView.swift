//
//  ContentView.swift
//  WorkoutList
//
//  Created by Jared Blanco on 4/11/22.
//
/*
 Welcome to the WorkoutList application source code,
 
 This is a very simple application that allows the user to make a modifed to-do list of "movments" (IE Pushups, bench, ect..).
 This to-do list view is located in WorkoutList.swift
 
 
 In addtion to displaying the list of movments, we can load "workouts" (list of movments) that we make or the user makes on their own.
 This feature can be viewed in workoutLoader.swift
 
 All objects used throuhgout the code are lcoated is WorkoutTemplate.swift
 
 Thank you for looking at my code, pleaes let me know if you have any style or feature recomendations :)
 */

import SwiftUI

struct ContentView: View {

    // movmentList is displayed/edited in workoutList() but can also be changed in workoutLoader()
    @State var movementList: [Movement] = loadMovementList()
    
    // workoutList is only viewed/edited in workoutLoader()
    @State var workoutList: [WorkoutTemplate] = loadWorkoutList()
    
    // pastWorkouts is viewed/edited in workoutHistory() and can also be added to in workoutList()
    @State var pastWorkouts: [WorkoutTemplate] = loadPastWorkouts()
    
    // selectedView is used in the tab view to choose which display is shown, edited in workoutList and workoutLoader
    @State var selectedView = 1

    
    var body: some View {
        TabView(selection: $selectedView) {
            // displays the movement list and can add movments
            WorkoutList(movementList: $movementList, pastWorkouts: $pastWorkouts, selectedView: $selectedView)
                .tabItem{Image(systemName: "wallet.pass.fill")}
                .tag(1)
                .preferredColorScheme(.light)
                
            // adds movments to the workoutList
            WorkoutLoader(movementList: $movementList, workoutList: $workoutList, selectedView: $selectedView)
                .tabItem{Image(systemName: "doc.on.doc")}
                .tag(2)
                .preferredColorScheme(.light)
            
            workoutHistory(pastWorkouts: $pastWorkouts)
                .tabItem{Image(systemName: "folder.fill")}
                .tag(3)
                .preferredColorScheme(.light)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .light)
    }
}



