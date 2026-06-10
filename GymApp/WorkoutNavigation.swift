
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
            ZStack {
                BackgroundView()
                VStack(spacing: 0) {
                    HStack {
                        Text("Workouts")
                            .font(.largeTitle.bold())
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)

                    if workouts.isEmpty {
                        Spacer()
                        VStack(spacing: 8) {
                            Image(systemName: "dumbbell")
                                .font(.system(size: 44))
                                .foregroundColor(.secondary)
                            Text("No workouts yet")
                                .font(.headline)
                                .foregroundColor(.secondary)
                            Text("Tap the + button to add one.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(spacing: 12) {
                                ForEach(workouts, id: \.self) { workout in
                                    WorkoutSelectionView(name: workout, workOuts: $workouts)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 16)
                            .padding(.bottom, 8)
                        }
                    }

                    AddWorkoutButton(isAddingWorkout: $isAddingWorkout)
                        .padding(.bottom, 16)
                }
            }
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

        let defaultWorkouts = [WorkoutViewModel.standardWorkoutName]
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
                Image(systemName: "plus")
                    .font(.system(size: 26, weight: .semibold))
                    .foregroundColor(.green)
                    .frame(width: 56, height: 56)
                    .background(Color(red: 0.98, green: 0.98, blue: 0.99))
                    .clipShape(Circle())
                    .shadow(color: Color.black.opacity(0.12), radius: 4, x: 0, y: 2)
        })
    }
    
}

struct WorkoutNavigations_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutNavigation()
    }
}
