//
//  WorkoutList.swift
//  WorkoutList
//
//  Created by Jared Blanco on 4/11/22.
//
/*
 Workout List is the primary element of the program. At it's core, it is a simple remake of a to-do list
 that presents the movment(task) as well as the sets and reps.
 
 The actual list is preceded by an area to enter indiviual movements.
 
 Inside the list, we can:
    - check movements as complete
    - delete movements from list with swipe
    - access the moreInfoView with swipe
 */

import SwiftUI

// displays the current list
struct WorkoutList: View {
   
    // list of movements that is presented to screen, can be added to in workoutLoader()
    @Binding var movementList: [Movement]
    
    // here we can complete a workout and add it to our past workouts
    @Binding var pastWorkouts: [WorkoutTemplate]
    
    // allows me to launch other screens from buttons
    @Binding var selectedView: Int
    
    // used to toble the more info menu for each movement
    @State private var showingWeightView = false
    @State private var weightIndex = 0
   
    
    // used in .ondelete in the list
    func removeRows(at offsets: IndexSet){
        movementList.remove(atOffsets: offsets)
        saveMovementList(movementList: movementList)
    }
        
    func onMove(source: IndexSet, destination: Int) {
        movementList.move(fromOffsets: source, toOffset: destination)
    }

    // WorkoutList: Main
    var body: some View {
        NavigationView{
            VStack{
                // contains text and logo
                WorkoutListHeaderView(movementList: $movementList)
                
                Divider()

                // allows user to type in one movment and add it to list
                addMovmentView(movementList: $movementList, save: true)
                
                Divider()
                
                //Added a reference key for the list
                HStack{
                    Text("Movments")
                        .frame(width: 140, alignment: .trailing)
                    Spacer()
                    Text("Sets x Reps")
                        .frame(width: 110, alignment: .leading)
                }
                
                Divider()
                
                // list of all movements in the movement list, refered to by index to make edditng easy
                List{
                    ForEach($movementList.indices, id: \.self) {index in
                        // shows the movment title, sets, resps and checkbox in format
                        MovementView(movmentObject: $movementList[index])
                            .swipeActions{
                                // delete button
                                Button("Delete")
                                {
                                    removeRows(at: IndexSet(integer: index))
                                }.tint(.red)
                                
                                // more button that allows user to enter weight and change fields in moreInfoView()
                                Button("More"){
                                    // this toggle presents the moreInfoView from the .sheet bellow
                                    showingWeightView.toggle()
                                    weightIndex = index
                                }.tint(.yellow)
                
                            }
                    }.listRowSeparator(.visible)
                    
                    workoutButtonsView(movementList: $movementList, pastWorkouts: $pastWorkouts, selectedView: $selectedView)
                }
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $showingWeightView){
                moreInfoView(movementList: $movementList, index: weightIndex)
            }
        }
    }
}
// displays name of page and logo
struct WorkoutListHeaderView: View{
    // can edit movment list in the header with the "clear" button
    @Binding var movementList: [Movement]

    var body: some View{
        HStack{
            Image("logo")
                .resizable()
                .frame(width: 30, height: 30)
            Text("Workout List")
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

// allows user to add a new movement to movement list
struct addMovmentView: View{
    // stirngs for the user to input their movement info
    @State var movementText: String="";
    @State var setsText: String="";
    @State var repsText: String="";
    
    // primary varable that can be added to
    @Binding var movementList: [Movement]
    
    // only save to our primary movement list if we are saving from workoutList.swift
    // this now allows addMovementView to be used in newWorkoutView.swift
    @State var save: Bool
    
    var body: some View{
        // includes the add workout parameters and button
        HStack{
            TextField("Add a Workout!", text: self.$movementText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 175, alignment: .center)
            
            TextField("Sets", text: self.$setsText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 55, alignment: .center)
                .keyboardType(.decimalPad)
            
            TextField("Reps", text: self.$repsText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 55, alignment: .center)
                .keyboardType(.decimalPad)
            

            // Button that adds the typed in movment and resets the filler text
            Button(action: {
                movementList.append(Movement(name:movementText, sets: String(setsText), reps: String(repsText), weight: "0"))
                if(save){saveMovementList(movementList: movementList)}
                self.movementText = "";
                self.repsText = "";
                self.setsText = "";
                hideKeyboard()
            }) {
                // Making our "Add" button pretty
                Text("Add!")
                    .padding(5)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .shadow(color: Color.black.opacity(0.25), radius: 6)
                    .foregroundColor(.white)
            }
        }
    }
}



// used in forEach to display each movement from movementList
struct MovementView: View{
    @Binding var movmentObject : Movement
    @State var checked = false
    var body: some View{
        HStack{
            CheckBox(checked: $checked).frame(width: 25, height: 25)
            Text(movmentObject.name)
                .frame(width: 190, alignment: .leading)
            Text(movmentObject.sets + "  x")
                .frame(width: 50, alignment: .trailing)
            Text(movmentObject.reps)
                .frame(width: 25, alignment: .leading)
        }
    }
}

// checkboxes for list of things in todo
struct CheckBox: View {
    @Binding var checked: Bool
    var body: some View {
        Button(action: {
            // on button click, "togggle" the bool value
            self.checked.toggle()
        }) {
            // changes image depending on value of checked
            Image(systemName: self.checked ? "checkmark.circle" : "circle").resizable().foregroundColor(.blue)
        }.buttonStyle(PlainButtonStyle())
    }
}

// contains completeWorkout and clearWorkout buttons
struct workoutButtonsView: View{
    // here is where we can clear the workout
    @Binding var movementList: [Movement]
    
    // here is where we can mark a workout as complete
    @Binding var pastWorkouts: [WorkoutTemplate]
    
    // we change to pastWorkoutView upon completing workout
    @Binding var selectedView: Int
    
    var body: some View{
        HStack{
            
            // clear workout button that removes all elements from movement list
            Button {
                movementList.removeAll()
                saveMovementList(movementList: movementList)
            } label: {
                Text("Clear Workout")
            }.font(.headline)
                    .frame(width: 140, height: 18)
                    .padding(5)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: Color.black.opacity(0.25), radius: 6)
                    .buttonStyle(BorderlessButtonStyle())
            
            // complete workout that saves the current workout to pastWorkouts
            Button {
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .full
                let name = String(dateFormatter.string(from: date))
                
                pastWorkouts.insert(WorkoutTemplate(name: name, movements: movementList), at: 0)
                savePastWorkouts(pastWorkouts: pastWorkouts)
                selectedView = 3
            } label: {
                Text("Complete Workout")
            }.font(.headline)
                    .frame(width: 150, height: 18)
                    .padding(5)
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 40))
                    .shadow(color: Color.black.opacity(0.25), radius: 6)
                    .buttonStyle(BorderlessButtonStyle())
                    .animation(.easeInOut, value: selectedView)
                    .transition(.slide)
        }
    }
}


// function used to help us hide keyboard in addMovemetView
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct WorkoutList_Previews: PreviewProvider {
    @State static var sampleList: [Movement] = [Movement(name: "Squats", sets: "3", reps: "3", weight: "0"),Movement(name: "Bench Press", sets: "3", reps: "3", weight: "0"), Movement(name: "Lunges", sets: "3", reps: "3", weight: "0") ]
    
    @State static var samplePastWorkouts: [WorkoutTemplate] = []
    @State static var samepleSelectedView = 1
    
    static var previews: some View {
        WorkoutList(movementList: $sampleList, pastWorkouts: $samplePastWorkouts, selectedView: $samepleSelectedView)
            .environment(\.colorScheme, .light)
    }
}



