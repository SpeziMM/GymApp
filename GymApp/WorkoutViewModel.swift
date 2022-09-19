
//
//  ExerciseViewModel.swift
//  GymApp
//
//  Created by Magnus Müller on 18.09.22.
//

import Foundation

// class that stores the data of a workout (all corresponding exercise combined)
class WorkoutViewModel: ObservableObject {
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
        exercs = [Exercise()]
    }
    // save workout in UserDefaults
    func save(){
        if let encoded = try? JSONEncoder().encode(exercs){
            UserDefaults.standard.set(encoded,forKey: self.workoutName)
        }
        
    }
    // delete Exercise from instance
    func removeExercise(idf : UUID){
        let idx = exercs.firstIndex(where: {$0.id == idf}) ?? 0
        exercs.remove(at: idx)
        //exercs.remove(firstIndex(where: $0.id = idf))
    }
    // add Exercise with default values
    func addExercise(){
        exercs.append(Exercise())
    }
    func getExercise(idf: UUID) -> Exercise{
        let idx = self.exercs.firstIndex(where: {$0.id == idf}) ?? 0
        return self.exercs[idx]
    }
    
}
