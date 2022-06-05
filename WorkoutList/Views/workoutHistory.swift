//
//  workoutHistory.swift
//  WorkoutList
//
//  Created by Jared Blanco on 6/1/22.
//
/*
 workoutHistory takes our completed workout from workoutList.swift and presents it with the day completed
 for user to reference later
 */

import Foundation
import SwiftUI

struct workoutHistory: View {
    @Binding var pastWorkouts: [WorkoutTemplate]
    
    var helpString = ""
    
    // used in .ondelete in the list
    func removeRows(at offsets: IndexSet){
        pastWorkouts.remove(atOffsets: offsets)
        savePastWorkouts(pastWorkouts: pastWorkouts)
        //saveMovementList(movementList: movementList)
    }
    
    var body: some View{
        
        
        VStack{
            
            workoutHistoryHeaderView()
            
            Divider()
            
            // list of all completed workouts
            List{
                ForEach(pastWorkouts, id: \.self) { work in
                    // allows for sub elements (list of movements) in each pastWorkout
                    DisclosureGroup("\(work.name)"){
                        VStack{
                            
                            ForEach(work.movements, id: \.self){movement in
                                HStack{
                                    Text("   -" + movement.name + ": ")
                                        .font(.caption)
                                        .lineLimit(1)
                                    Spacer()
                                    
                                    Text(movement.sets)
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                    Text("x")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                    Text(movement.reps)
                                        .font(.caption)
                                        .frame(alignment: .trailing)
                                    Text("with")
                                        .font(.caption)
                                        .multilineTextAlignment(.trailing)
                                    Text("\(movement.weight)lbs")
                                        .font(.caption)
                                        .frame(alignment: .trailing)
                                }
                            }
                        }
                    }
                }
                .onDelete(perform: removeRows)
                .listRowSeparator(.visible)
            }
        }
    }
}

// contains name and logo
struct workoutHistoryHeaderView: View{
    var body: some View{
        HStack{
            Image("logo")
                .resizable()
                .frame(width: 30, height: 30)
            Text("Workout History")
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)

        }.frame(minWidth: 300, maxWidth: .infinity, maxHeight: 15)
            .background(Color.blue)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(5)
    }
}

struct workoutHistory_Preview: PreviewProvider{
    @State static var pastWorkouts = loadPastWorkouts()
    static var previews: some View{
        workoutHistory(pastWorkouts: $pastWorkouts)
    }
}
