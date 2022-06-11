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

// can either show workout history in calender or list view
struct workoutHistory: View {
    @Binding var pastWorkouts: [WorkoutTemplate]
    @Binding var selectedView: Int
    @State var showCalender = true
    
    var body: some View{
        NavigationView{
            if(showCalender == false){
                historyListView(pastWorkouts: $pastWorkouts, showCalender: $showCalender)
                    .navigationBarHidden(true)
            }else if(showCalender == true){
                historyCalenderView(showCalender: $showCalender, pastWorkouts: pastWorkouts)
                    .navigationBarHidden(true)
            }
        }
    }
}

// calender view: shows the workout that was compelted that day
struct historyCalenderView: View {
    @State var date = Date()
    @Binding var showCalender: Bool
    @State var pastWorkouts: [WorkoutTemplate]
    
    // returns the workout that was completed on the selected date from datepicker
    func getWorkoutFromDate(searchDate: Date) -> WorkoutTemplate {
        let output: WorkoutTemplate
        let index = pastWorkouts.firstIndex(where: {$0.name == String(searchDate.formatted(date: .complete, time: .omitted))}) ?? -1
        if(index == -1){
            output = WorkoutTemplate(name: "No Workout Completed", movements: [Movement(name: "No Workout Complete", sets: "", reps: "", weight: "")])
        }else{
            output = pastWorkouts[index]
        }
        
        return output
        
    }
    
    var body: some View {
        VStack{
            workoutHistoryHeaderView()
            
            // big pretty calender
            DatePicker("Today", selection: $date, displayedComponents: .date)
                .datePickerStyle(GraphicalDatePickerStyle())

            // shows the selected date
            Text(date.formatted(date: .complete, time: .omitted))
            
            // shows the completed movements on that date
            ForEach(getWorkoutFromDate(searchDate: date).movements, id: \.self){movement in
                
                // shows the movements complete or just the "no workouts completed
                HStack{
                    Text("   -" + movement.name + ": ")
                        .font(.caption)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if(movement.name != "No Workout Complete"){
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
            
            Spacer()
            
            // used to change to list view
            Picker("View", selection: $showCalender){
                Text("Calendar")
                    .tag(true)
                Text("List")
                    .tag(false)
            }.pickerStyle(SegmentedPickerStyle())
        }
    }
}


// list view of workout History
struct historyListView: View{
    @Binding var pastWorkouts: [WorkoutTemplate]
    @Binding var showCalender: Bool
    
    // used in .ondelete in the list
    func removeRows(at offsets: IndexSet){
        pastWorkouts.remove(atOffsets: offsets)
        savePastWorkouts(pastWorkouts: pastWorkouts)
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
                        workoutHistoryDetails(work: work)
                    }
                }
                .onDelete(perform: removeRows)
                .listRowSeparator(.visible)
            }
            Spacer()
            
            Picker("View", selection: $showCalender){
                Text("Calendar")
                    .tag(true)
                Text("List")
                    .tag(false)
            }.pickerStyle(SegmentedPickerStyle())
             
        }
    }
}

struct workoutHistoryDetails: View{
    @State var work: WorkoutTemplate
    var body: some View{
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
    @State static var selectedView = 4
    static var previews: some View{
        workoutHistory(pastWorkouts: $pastWorkouts, selectedView: $selectedView)
    }
}
