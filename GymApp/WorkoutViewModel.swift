
//
//  ExerciseViewModel.swift
//  GymApp
//
//  Created by Magnus Müller on 18.09.22.
//

import Foundation

// class that stores the data of a workout (all corresponding exercise combined)
class WorkoutViewModel: ObservableObject {
    /// name of the standard workout that ships with a ready-made template
    static let standardWorkoutName = "Demo Workout"
    /// name of the instace/workout
    var workoutName: String
    /// List that store the exercises of a workout
    @Published var exercs: [Exercise]
    init(workoutName: String){
        self.workoutName = workoutName
        if let data = UserDefaults.standard.data(forKey: self.workoutName){
            if let decoded = try? JSONDecoder().decode([Exercise].self, from: data){
                exercs = decoded
                return
            }
        }
        exercs = Self.defaultExercises(for: workoutName)
    }

    // first-time contents for a freshly opened workout: the standard workout
    // gets a full template, any other new workout starts with a single blank exercise
    private static func defaultExercises(for workoutName: String) -> [Exercise] {
        guard workoutName == standardWorkoutName else { return [Exercise()] }
        return templateExercises()
    }

    // a ready-made push-day template used for the standard workout
    private static func templateExercises() -> [Exercise] {
        [
            Exercise(name: "Bench Press", sets: [GymSet(weight: "40.00", repAmt: 10), GymSet(weight: "40.00", repAmt: 10), GymSet(weight: "40.00", repAmt: 8)]),
            Exercise(name: "Incline Bench Press", sets: [GymSet(weight: "30.00", repAmt: 10), GymSet(weight: "30.00", repAmt: 8)]),
            Exercise(name: "Butterfly", sets: [GymSet(weight: "25.00", repAmt: 12), GymSet(weight: "25.00", repAmt: 12)]),
            Exercise(name: "Shoulder Press", sets: [GymSet(weight: "20.00", repAmt: 10), GymSet(weight: "20.00", repAmt: 10)]),
            Exercise(name: "Triceps Push Down", sets: [GymSet(weight: "25.00", repAmt: 12), GymSet(weight: "25.00", repAmt: 12), GymSet(weight: "25.00", repAmt: 10)]),
        ]
    }
    // save workout in UserDefaults
    func save(){
        if let encoded = try? JSONEncoder().encode(exercs){
            UserDefaults.standard.set(encoded,forKey: self.workoutName)
        }
        
    }
    // delete Exercise from instance
    func removeExercise(idf : UUID){
        guard let idx = exercs.firstIndex(where: {$0.id == idf}) else { return }
        exercs.remove(at: idx)
    }
    // add Exercise with default values
    func addExercise(){
        exercs.append(Exercise())
    }
    func getExercise(idf: UUID) -> Exercise{
        guard let idx = self.exercs.firstIndex(where: {$0.id == idf}) else {
            return Exercise()
        }
        return self.exercs[idx]
    }
    
}
