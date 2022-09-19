//
//  AddWorkoutView.swift
//  GymApp
//
//  Created by Magnus Müller on 18.09.22.
//

import SwiftUI

// view to add a workout
struct AddWorkoutView: View{
    /// list of all current workouts
    @Binding var workouts: [String]
    /// name of the new workout
    @State var workout: String = ""
    /// state to exit view back to  workoutNavigation
    @Binding var ifAddWorkout: Bool
    /// error message for invalid input
    @State var errorMessage = ""
    var body: some View{
        VStack(spacing:0){
            if(errorMessage != ""){
                Text(errorMessage)
                    .foregroundColor(.red)
            }
            TextField("select your workout name",text: $workout)
                .frame(width: 225,height: 25)
                .textFieldStyle(.roundedBorder)
                .padding(.leading,10)
                .padding(.top, 10)
                .padding(.bottom,25)
                .onChange(of: workout){[workout] newValue in
                    errorMessage = ""
                }
           
            Button("confirm"){
                if(workout == "" || workouts.contains(workout)){
                    errorMessage = "invalid input"
                }else{
                    addWorkout(workout: workout)
                    ifAddWorkout = false
                }
            }
        }
    }
    
    // add workout to workouts and safe it in UserDefaults
    func addWorkout(workout: String){
        workouts.append(workout)
        UserDefaults.standard.set(workouts, forKey: "Workouts")
    }
}


struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        AddWorkoutView(workouts: .constant(["Default Workout"]), ifAddWorkout: .constant(true))
    }
}
