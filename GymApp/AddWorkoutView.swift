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
    @Binding var isAddingWorkout: Bool
    /// error message for invalid input
    @State var errorMessage = ""
    var body: some View{
        Form {
            Section(header: Text("Add Workout"), footer: Text(errorMessage).foregroundColor(.red)) {
                TextField("select your workout name", text: $workout)
                    .onChange(of: workout){ _, _ in
                        errorMessage = ""
                    }
                
                Button("confirm"){
                    if(workout == "" || workouts.contains(workout)){
                        errorMessage = "invalid input"
                    }else{
                        addWorkout(workout: workout)
                        isAddingWorkout = false
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
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
        AddWorkoutView(workouts: .constant(["Default Workout"]), isAddingWorkout: .constant(true))
    }
}
