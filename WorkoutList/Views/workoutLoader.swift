//
//  workoutLoader.swift
//  WorkoutList
//
//  Created by Jared Blanco on 4/11/22.
//
/*
 WorkoutLoader is a support element to workoutList. This file uses the workoutTemplate object that is located
 in workoutTemplate. We use this object to easily present user with a list of movemetnst that they can append
 to the list presented in workoutList.
 
 In additon, we can delete workoutTemplates and have a navigtion link to the newWorkoutView where we can
 add a new workoutTemplate object to our list "workoutList"
 */

import SwiftUI



struct WorkoutLoader: View {
    // list displayed in workoutList.swift (main home view)
    @Binding var movementList: [Movement]
    
    // used to be able to delete workouts
    @State var editMode: Bool = false;

    // List of sample workouts that the user can have, later on will be able to add to the list
    @Binding var workoutList: [WorkoutTemplate]
    
    // allows me to launch other screens from buttons
    @Binding var selectedView: Int
    
    @State var showingAddScreen = false

    // used later to iterate through lazy grid
    var items: [GridItem] {
        return Array(repeating: .init(.fixed(140)), count: 2)
    }
    
    // used in .ondelete in the list
    func removeRows(at offsets: IndexSet){
        workoutList.remove(atOffsets: offsets)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                
                // contains text, the edit button, and the navigationLink to newWOrkoutView()
                WorkoutLoaderHeaderView(workoutList: $workoutList, editMode: $editMode, showingAddScreen: $showingAddScreen)
                
                Divider()
        
                ScrollView{
                    // A lazy grid gives us the 2 views next to eachother
                    LazyVGrid(columns: items, spacing: 10, pinnedViews: [.sectionHeaders]){
                        // for each workout in our list, we present it in view WorkoutTemplateViewer
                        ForEach(workoutList, id: \.self) { work in
                            //OptimizedWorkoutTemplateViewer(workoutVariable: work, movementList: $movementList, editMode: $editMode, workoutList: $workoutList, selectedView: $selectedView)
                            WorkoutTemplateViewer(workoutVariable: work, movementList: $movementList, editMode: $editMode, workoutList: $workoutList, selectedView: $selectedView)
                        }
                    }
                }
                
                Spacer()
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingAddScreen){
                newWorkoutView(workoutList: $workoutList)
            }
        }
    }
}

// contains delete/add button and view name
struct WorkoutLoaderHeaderView: View{
    // list of workouts that we can link to newWorkoutView to add to
    @Binding var workoutList: [WorkoutTemplate];
    
    // used to dicern if we are delting workouts
    @Binding var editMode: Bool;
    
    // used to link WorkoutLoader with newWorkoutVIew()
    @Binding var showingAddScreen: Bool;
    
    var body: some View{

        HStack{
            // edit button that turns on editMode, will now show flipped sign in each worokutView
            Button {
                editMode.toggle()
            } label: {
                Text("-")
                    .font(.headline)
                    .frame(width: 15, height: 18)
                    .padding(5)
                    .foregroundColor(.black)
                    .background(editMode ? Color.red : Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: Color.black.opacity(0.25), radius: 6)
            }
            
            Text("Workout Loader")
                .font(.title)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
            
            // the Plus button will togle the add scnre, than workoutLoader() will call newWorkoutVIew()
            Button {
                if (editMode){editMode.toggle()}
                    
                showingAddScreen.toggle()
            } label: {
                Text("+")
                    .font(.headline)
                    .frame(width: 15, height: 18)
                    .padding(5)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: Color.black.opacity(0.25), radius: 6)
            }

        }.frame(minWidth: 300, maxWidth: .infinity, maxHeight: 15)
            .padding()
            .foregroundColor(.white)
            .background(.blue)
            .cornerRadius(5)
    }
}

// button togles from adding workout to movementList or can also be used to delete the workout
struct addOrEditButtonView: View{
    // list of all workouts on the screen that we delete from
    @Binding var workoutList: [WorkoutTemplate]
    
    // discerns if we add workout to movmentList OR delete it from workoutList
    @Binding var editMode: Bool;
    
    // passed in forEach later in code
    var workoutVariable : WorkoutTemplate
    
    // list of movmetns from workoutList()
    @Binding var movementList: [Movement]
    
    // allows me to launch other screens from buttons
    @Binding var selectedView: Int
    
    var body: some View{
        // if we are not editing we can add workout to list
        if(editMode == false){
            Button(action: {
                for movment in workoutVariable.movements{
                    movementList.append(movment)
                }
                saveMovementList(movementList: movementList)
                selectedView = 1
            }) {
                // Making our "Add" button pretty
                Text("+ ")
                    .font(.headline)
                    .frame(width: 15, height: 18)
                    .padding(5)
                    .foregroundColor(.black)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            }
        // if we are in edit mode we can delete the workout
        }else{
            Button(action: {
                if let index = workoutList.firstIndex(of: workoutVariable) {
                    workoutList.remove(at: index)
                }
                saveWorkoutList(workoutList: workoutList)
            }) {
                // Making our "Add" button pretty
                Text("- ")
                    .font(.headline)
                    .frame(width: 15, height: 18)
                    .padding(5)
                    .foregroundColor(.black)
                    .background(Color.red)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
            }
        }
    }
}

// contains the square object shown on screen in lazy grid
struct WorkoutTemplateViewer: View{
    // one element from list of workouts
    var workoutVariable : WorkoutTemplate
    // primary list on first page
    @Binding var movementList: [Movement]
    
    @Binding var editMode: Bool;
    
    @Binding var workoutList: [WorkoutTemplate]
    
    // allows me to launch other screens from buttons
    @Binding var selectedView: Int
    
    var body: some View {
        VStack{
            // the header of the workoutObject
            ZStack{
                RoundedRectangle(cornerRadius: 40)
                    .fill(Color.black)
                    .frame(width: 125, height: 35)
                    .padding(.top, 10)
                   
                HStack{
                    Text(workoutVariable.name)
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .frame(width: 70, height: 18)
                    
                    // button that can either add wrokout to movementList or delete the workout from workoutList
                    addOrEditButtonView(workoutList: $workoutList, editMode: $editMode, workoutVariable: workoutVariable, movementList: $movementList, selectedView: $selectedView)

                }.padding(.top, 10)
            }
            
            

            // just lists all movments, sets, and reps in the workout
            ForEach(workoutVariable.movements, id: \.self) { lift in
                HStack{
                    Text(" -\(lift.name) :")
                        .font(.caption)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Text("\(lift.sets) x \(lift.reps)  ")
                        .font(.caption)
                }
            }
            Spacer()
        }
        .frame(minWidth: 140, maxWidth: 140, minHeight: 160, maxHeight: .infinity, alignment: .topTrailing)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous)
            .fill(.blue))
    }
}

// contains the square object shown on screen in lazy grid
struct OptimizedWorkoutTemplateViewer: View{
    // one element from list of workouts
    var workoutVariable : WorkoutTemplate
    // primary list on first page
    @Binding var movementList: [Movement]
    
    @Binding var editMode: Bool;
    
    @Binding var workoutList: [WorkoutTemplate]
    
    // allows me to launch other screens from buttons
    @Binding var selectedView: Int
    
    var body: some View {
        VStack{
            HStack{
                Text(workoutVariable.name)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black)
                    .frame(width: 70, height: 18)
                
                Spacer()
                
                // button that can either add wrokout to movementList or delete the workout from workoutList
                addOrEditButtonView(workoutList: $workoutList, editMode: $editMode, workoutVariable: workoutVariable, movementList: $movementList, selectedView: $selectedView)
                
            }.frame(maxWidth: 80, maxHeight: 30, alignment: .topTrailing)
                .padding(.top, 20)
            
            Divider()
            
            // just lists all movments, sets, and reps in the workout
            ForEach(workoutVariable.movements, id: \.self) { lift in
                HStack{
                    Text("  " + lift.name)
                        .font(.caption)
                        .foregroundColor(Color.gray)
                        .lineLimit(1)
                        

                    Spacer()
                }
            }
            
            Spacer()
        }
        .frame(minWidth: 140, maxWidth: 140, minHeight: 160, maxHeight: .infinity, alignment: .topTrailing)
        .background(RoundedRectangle(cornerRadius: 30, style: .continuous).fill(.blue)
        )
    }
}

struct WorkoutLoader_Previews: PreviewProvider {
    @State static var sampleList: [Movement] = [Movement(name: "Squats", sets: "3", reps: "3", weight: "0"),Movement(name: "Squats", sets: "3", reps: "3", weight: "0"), Movement(name: "Lunges", sets: "3", reps: "3", weight: "0") ]
    
    @State static var workoutList: [WorkoutTemplate] = [
            WorkoutTemplate(name: "Arms", movements: [Movement(name: "DB curls", sets: "3", reps: "12", weight: "0"), Movement(name: "Tricep extensions", sets: "3", reps: "12", weight: "0"),Movement(name: "shoulder press", sets: "3", reps: "8", weight: "0"),Movement(name: "lateral raise", sets: "3", reps: "20", weight: "0"),Movement(name: "hammers", sets: "3", reps: "12", weight: "0") ]),
            WorkoutTemplate(name: "Back", movements: [Movement(name: "Deadlifts", sets: "3", reps: "3", weight: "0"), Movement(name: "Rows", sets: "3", reps: "3", weight: "0"),Movement(name: "LattPD", sets: "3", reps: "3", weight: "0") ]),
            WorkoutTemplate(name: "Chest", movements: [Movement(name: "Bench", sets: "3", reps: "3", weight: "0"), Movement(name: "Flys",sets: "3", reps: "3", weight: "0"),Movement(name: "Pushups", sets: "3", reps: "3", weight: "0") ]),
            WorkoutTemplate(name: "Legs", movements: [Movement(name: "Squats", sets: "3", reps: "3", weight: "0"), Movement(name: "Lunges", sets: "3", reps: "3", weight: "0"),Movement(name: "LegPress", sets: "3", reps: "3", weight: "0") ])
        ]
    
    @State static var selectedView = 2
    
    static var previews: some View {
        WorkoutLoader(movementList: $sampleList,workoutList: $workoutList, selectedView: $selectedView)
            .environment(\.colorScheme, .dark)
    }
}


