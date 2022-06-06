//
//  newWorkoutView.swift
//  WorkoutList
//
//  Created by Jared Blanco on 4/24/22.
//
/*
 newWoroutView is a pop up screen that is accessed from workoutLoader. This screen allows user to create a
 new workoutTemplate object and add it to the workoutList.
 
 */
import Foundation
import SwiftUI

// models after main workoutList View to add a new workoutTemplate
struct newWorkoutView: View{
    // this is used to dismiss the view after saving
    @Environment(\.dismiss) var dismiss
    @State var titleText: String="";
    @State var movementList: [Movement] = []
    @Binding var workoutList: [WorkoutTemplate];
    
    // used in .ondelete in the list
    func removeRows(at offsets: IndexSet){
        movementList.remove(atOffsets: offsets)
    }
    
    var body: some View{
        VStack{
            Text("Add a new workout")
                .frame(minWidth: 300, maxWidth: .infinity)
                .font(.title)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(5)
            
            Divider()
            
            // Text field to add title
            TextField("Title", text: self.$titleText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.title)
            
            Divider()
            
            // Function from WorkoutList.swift: allows user to type in one movment and add it to list
            addMovmentView(movementList: $movementList, save: false)

            
            Divider()
            
            List{
                ForEach($movementList, id: \.self) {lift in
                    NoCheckBoxMovementView(movmentObject: lift)}
                    .onDelete(perform: removeRows)
                    .listRowSeparator(.visible)
            }
            
            Spacer()
            
            Button(action: {
                // added incase the user just added a blank
                if(movementList.isEmpty){
                    movementList.append(Movement(name: "Example", sets: "3", reps: "3", weight: "0"))
                    titleText = "Title"
                }
                workoutList.append(WorkoutTemplate(name: titleText, movements: movementList))
                saveWorkoutList(workoutList: workoutList)
                dismiss()
                
            }) {
                // Making our "Add" button pretty
                Text("Save")
                    .frame(width: 300, alignment: .center)
                    .padding(5)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(color: Color.black.opacity(0.25), radius: 6)
                    .foregroundColor(.white)
            }
        }
    }
}

// movement view from workoutList without the checkbox
struct NoCheckBoxMovementView: View{
    @Binding var movmentObject : Movement
    var body: some View{
        HStack{
            Text(movmentObject.name)
                .frame(width: 190, alignment: .leading)
            Text(movmentObject.sets + "  x")
                .frame(width: 50, alignment: .trailing)
            Text(movmentObject.reps)
                .frame(width: 20, alignment: .leading)
        }
    }
}

struct newWorkoutView_Preview: PreviewProvider{
    // List of sample workouts that the user can have, later on will be able to add to the list
    @State static var workoutList = [
            WorkoutTemplate(name: "Arms", movements: [Movement(name: "Squats", sets: "3", reps: "3", weight: "0"), Movement(name: "Lunges", sets: "3", reps: "3", weight: "0"),Movement(name: "LegPress", sets: "3", reps: "3", weight: "0") ]),
            WorkoutTemplate(name: "Back", movements: [Movement(name: "Deadlifts", sets: "3", reps: "3", weight: "0"), Movement(name: "Rows", sets: "3", reps: "3", weight: "0"),Movement(name: "LattPD", sets: "3", reps: "3", weight: "0") ]),
            WorkoutTemplate(name: "Chest", movements: [Movement(name: "Bench", sets: "3", reps: "3", weight: "0"), Movement(name: "Flys", sets: "3", reps: "3", weight: "0"),Movement(name: "Pushups", sets: "3", reps: "3", weight: "0") ]),
            WorkoutTemplate(name: "Legs", movements: [Movement(name: "Squats", sets: "3", reps: "3", weight: "0"), Movement(name: "Lunges", sets: "3", reps: "3", weight: "0"),Movement(name: "LegPress", sets: "3", reps: "3", weight: "0") ])
        ]
    
    static var previews: some View {
        newWorkoutView(workoutList: $workoutList)
    }
}
