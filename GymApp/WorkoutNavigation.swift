
//
//  WorkoutNavigation.swift
//  GymApp
//
//  Created by Magnus Müller on 06.09.22.
//

import SwiftUI

// main NavigationView to select a workout
struct WorkoutNavigation: View {
    /// perform nevagation to ContentView if true
    @State var isActive = false
    /// perform nevagation to addWorkoutView if true
    @State var ifAddWorkout = false
    /// selected workout
    @State var selection = "Workout"
    /// stores the names of all workouts (with UserDefaults)
    @State var workouts = UserDefaults.standard.array(forKey: "Workouts") as? [String] ?? []

    var body: some View {
        NavigationView{
            VStack{
                Text("Work Out")
                    .bold()
                    .font(.system(size: 30))
                ScrollView(){
                    
                    Spacer()
                    ForEach(workouts , id: \.self){workout in
                        WorkoutSelectionView(name: workout, isActive: $isActive,selection: $selection, workOuts: $workouts)
                        .onDisappear(){
                                UserDefaults.standard.set(workouts, forKey: "Workouts")
                            }
                    }
                    
                    NavigationLink(destination: ContentView(viewModel: WorkoutViewModel(workoutName: selection)), isActive: $isActive) {EmptyView()
                    }
                    NavigationLink(destination: AddWorkoutView(workouts: $workouts, ifAddWorkout: $ifAddWorkout), isActive: $ifAddWorkout) {EmptyView()
                    }

                }
                .cornerRadius(20)
                AddWorkoutButton(ifAddWorkout: $ifAddWorkout)
                    .padding()
            }

            Spacer()
        }
        
    }
}

// adds workout to "workouts" with button press after navigation to AddWorkoutView
struct AddWorkoutButton: View{
    @Binding var ifAddWorkout: Bool
    var body: some View{
        Button(action:{
                ifAddWorkout = true
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
