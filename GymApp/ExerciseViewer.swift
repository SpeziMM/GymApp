//
//  ExerciseViewer.swift
//  Gymhelper
//
//  Created by Magnus Müller on 23.08.22.
//

import SwiftUI

// displays one Exercise with its data
struct ExerciseViewer: View {
    /// instance that stores the data of a Workout
    @EnvironmentObject var viewModel: WorkoutViewModel
    var idf: UUID
    var body: some View{
        VStack(spacing: 16) {
            HStack {
                if let idx = viewModel.exercs.firstIndex(where: {$0.id == idf}){
                    TextField("Exercise name", text: $viewModel.exercs[idx].name)
                        .font(.title3)
                        .textFieldStyle(.roundedBorder)
                        .padding(.vertical, 6)
                }
                Button(action:{
                    viewModel.removeExercise(idf: idf)
                       }, label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 22, height: 22)
                            .foregroundColor(.red)
                            .padding(.leading, 8)
                })
            }
            .padding(.horizontal, 12)

            if let idx = viewModel.exercs.firstIndex(where: {$0.id == idf}){
                ForEach($viewModel.exercs[idx].sets) { currSet in
                    VStack(spacing: 12){
                        WeightSetterViewer(gymSet: currSet)
                        RepsViewer(gymSet: currSet)
                    }
                    .padding(12)
                    .background(Color(red: 0.94, green: 0.95, blue: 0.97))
                    .cornerRadius(18)
                }
            }

            HStack(spacing: 20) {
                Button(action:{
                    if(viewModel.getExercise(idf: idf).setAmt()>1){
                        if let idx = viewModel.exercs.firstIndex(where: {$0.id == idf}){
                            viewModel.exercs[idx].removeLastSet()
                        }
                    }
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 32, height: 32)
                            .foregroundColor(.red)
                    })

                Text("set")
                    .bold()
                    .font(.body)
                    .frame(width: 40, height: 36)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.primary)

                Button(action:{
                    if let idx = viewModel.exercs.firstIndex(where: {$0.id == idf}){
                        let lastSet: GymSet = viewModel.exercs[idx].getLastSet()
                        viewModel.exercs[idx].addSet(weight: lastSet.weight, repAmt: lastSet.repAmt)
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundColor(.green)
                })
            }
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.94, green: 0.94, blue: 0.96))
            .cornerRadius(18)
            .padding(.horizontal, 12)
            .padding(.bottom, 12)
        }
        .padding(.vertical, 16)
        .frame(maxWidth: .infinity)
        .background(Color(red: 0.98, green: 0.98, blue: 0.99))
        .cornerRadius(22)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 3)
        .padding(.horizontal, 8)
    }
}
