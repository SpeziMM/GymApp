//
//  WorkoutSelectionView.swift
//  GymApp
//
//  Created by Magnus Müller on 18.09.22.
//

import SwiftUI

// view to select a certain workout -> navigate to it (from WorkoutNavigation -> ContentView)
struct WorkoutSelectionView: View{
    /// name of workout
    let name: String
    /// list of all workouts
    @Binding var workOuts: [String]
    var body: some View{
        ZStack(alignment: .topTrailing) {
            // navigation button
            NavigationLink(destination: ContentView(viewModel: WorkoutViewModel(workoutName: name))) {
                Text(name)
                    .frame(width: 190, height: 60)
                    .background(.white)
                    .contentShape(Rectangle())
                    .cornerRadius(20)
            }
            .frame(width: 300, height: 100, alignment: .center)
            .background(.red)
            .cornerRadius(20)

            // button to delete workout
            Button(action:{
                deleteWorkout()
                   }, label: {
                    Image(systemName: "xmark.circle.fill")
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .foregroundStyle(.red,  Color(red: 60 / 255, green: 60 / 255, blue: 60 / 255))
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .padding(16)
            })
        }
    }
    // delete Workout and remove data from Userdefaults
    func deleteWorkout(){
        guard let idx = workOuts.firstIndex(where: {$0 == name}) else { return }
        UserDefaults.standard.removeObject(forKey: name)
        workOuts.remove(at: idx)

    }
}

struct WorkoutSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            WorkoutSelectionView(name: "default", workOuts: .constant(["default"]))
        }
    }
}
