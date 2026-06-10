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
        NavigationLink(destination: ContentView(viewModel: WorkoutViewModel(workoutName: name))) {
            HStack(spacing: 12) {
                Text(name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Button(action: {
                    deleteWorkout()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 22, height: 22)
                        .foregroundColor(.red.opacity(0.8))
                })
                .buttonStyle(.plain)
                Image(systemName: "chevron.right")
                    .font(.subheadline.weight(.semibold))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 18)
            .padding(.vertical, 16)
            .background(Color(red: 0.98, green: 0.98, blue: 0.99))
            .cornerRadius(18)
            .shadow(color: Color.black.opacity(0.06), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(.plain)
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
