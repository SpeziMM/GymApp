
//
//  WorkoutNavigation.swift
//  GymApp
//
//  Created by Magnus Müller on 06.09.22.
//

import SwiftUI

// main NavigationView to select a workout
struct WorkoutNavigation: View {
    /// stores the names of all workouts (with UserDefaults)
    @State private var workouts = Self.loadWorkouts()
    /// presents the add-workout screen
    @State private var isAddingWorkout = false

    var body: some View {
        NavigationStack {
            VStack{
                Text("Work Out")
                    .bold()
                    .font(.system(size: 30))
                ScrollView(){
                    Spacer()
                    ForEach(workouts , id: \.self){workout in
                        WorkoutSelectionView(name: workout, workOuts: $workouts)
                    }
                }
                .cornerRadius(20)
                AddWorkoutButton(isAddingWorkout: $isAddingWorkout)
                    .padding()
            }
            Spacer()
        }
        .sheet(isPresented: $isAddingWorkout) {
            AddWorkoutView(workouts: $workouts, isAddingWorkout: $isAddingWorkout)
                .presentationDetents([.height(180)])
        }
        .onChange(of: workouts) { _, newWorkouts in
            UserDefaults.standard.set(newWorkouts, forKey: "Workouts")
        }
    }

    private static func loadWorkouts() -> [String] {
        let savedWorkouts = UserDefaults.standard.array(forKey: "Workouts") as? [String] ?? []
        guard savedWorkouts.isEmpty else { return savedWorkouts }

        let defaultWorkouts = ["Demo Workout"]
        UserDefaults.standard.set(defaultWorkouts, forKey: "Workouts")
        return defaultWorkouts
    }
}

// adds workout to "workouts" with button press after navigation to AddWorkoutView
struct AddWorkoutButton: View{
    @Binding var isAddingWorkout: Bool
    var body: some View{
        Button(action:{
                isAddingWorkout = true
            }, label: {
                Image(systemName: "plus.circle.fill")
                .symbolRenderingMode(.palette)
                .resizable()
                .foregroundStyle(.red, .green, .black)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
        })
    }
    
}

struct WorkoutNavigations_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutNavigation()
    }
}
