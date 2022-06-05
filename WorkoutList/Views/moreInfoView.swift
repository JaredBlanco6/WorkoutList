//
//  moreInfoView.swift
//  WorkoutList
//
//  Created by Jared Blanco on 6/3/22.
//
/*
 moreInfoView is a supporting view to the workoutList.swift. In this view, we give the user the ability to
 add weight used on their movement as well as the ability to edit the existing movement object.
 */

import Foundation
import SwiftUI


struct moreInfoView: View{
    // this is used to dismiss the view after saving
    @Environment(\.dismiss) var dismiss
    
    // primary list that we can edit
    @Binding var movementList: [Movement]
    
    // index of the element of movementList we are editing
    @State var index: Int
    
    @State var weightText = ""
    @State var setsText: String="";
    @State var repsText: String="";
    @State var titleText: String="";
    
    var body: some View{
        VStack{
            Text("Workout Details")
                .frame(minWidth: 300, maxWidth: .infinity)
                .font(.title)
                .padding()
                .foregroundColor(.white)
                .background(.blue)
                .cornerRadius(5)
                .onAppear{
                    titleText = movementList[index].name
                }
            
            // Text field to add title
            TextField("Title", text: self.$titleText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(width: 300, alignment: .center)
                .multilineTextAlignment(.center)
                .font(.title)
            
            
            // includes the add workout parameters and button
            HStack{

                
                TextField("Sets", text: self.$setsText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 55, alignment: .center)
                    .keyboardType(.decimalPad)
                    .onAppear{
                        setsText = movementList[index].sets
                    }
                
                Text(" x ")
                
                TextField("Reps", text: self.$repsText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 55, alignment: .center)
                    .keyboardType(.decimalPad)
                    .onAppear{
                        repsText = movementList[index].reps
                    }
                Text(" at: ")
                
                TextField("Weight", text: self.$weightText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 55, alignment: .center)
                    .keyboardType(.decimalPad)
                    .onAppear{
                        weightText = movementList[index].weight
                    }
                

                // Button that adds the typed in movment and resets the filler text
                Button(action: {
                    movementList[index].name = titleText
                    movementList[index].sets = setsText
                    movementList[index].reps = repsText
                    movementList[index].weight = weightText
                    saveMovementList(movementList: movementList)
                    dismiss()
                }) {
                    // Making our "Add" button pretty
                    Text("Save!")
                        .padding(5)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .shadow(color: Color.black.opacity(0.25), radius: 6)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
        }
    }
}

struct moreInfoView_Previews: PreviewProvider {
    @State static var sampleList: [Movement] = [Movement(name: "Squats", sets: "3", reps: "3", weight: "0"),Movement(name: "Bench Press", sets: "3", reps: "3", weight: "0"), Movement(name: "Lunges", sets: "3", reps: "3", weight: "0") ]
    
    @State static var sampleIndex = 1
    
    
    static var previews: some View {
        moreInfoView(movementList: $sampleList, index: sampleIndex)
    }
}
