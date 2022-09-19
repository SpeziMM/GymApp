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
    @State var name: String
    /// binding for performing navigation to the data of a workout
    @Binding var isActive: Bool
    /// binding to tell to which workout should be navigated
    @Binding var selection: String
    /// list of all workouts
    @Binding var workOuts: [String]
    var body: some View{
        HStack{
            // navigation button
            Button(action: {
                isActive = true
                selection = name },
                   label: {
                    Text(name)
                    .frame(minWidth: 175,minHeight: 50)
                    .background()
                    .contentShape(Rectangle())
                    .cornerRadius(20)
                })
            .padding(.leading,50)

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
                    .padding(.leading,25)
                    .padding(.bottom,60)
            })
        }
        .frame(width: 300, height: 100, alignment: .center)
        .background(.red)
        .cornerRadius(20)
        
        
    }
    // delete Workout and remove data from Userdefaults
    func deleteWorkout(){
        let idx = workOuts.firstIndex(where: {$0 == selection}) ?? 0
        UserDefaults.standard.removeObject(forKey: selection)
        workOuts.remove(at: idx)

    }
}

struct WorkoutSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        WorkoutSelectionView(name: "default", isActive: .constant(false), selection: .constant("default"), workOuts: .constant(["default"]))
    }
}
