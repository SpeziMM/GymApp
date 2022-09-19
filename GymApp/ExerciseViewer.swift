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
    /// instance that stores the data of the current Exercise
    @State var currExercise: Exercise
    var idf: UUID
    var body: some View{
         ScrollView{
            HStack {
                Spacer(minLength: 80)
                if let idx = viewModel.exercs.firstIndex(where: {$0.id == idf}){
                    TextField("Exercise",text:$viewModel.exercs[idx].name)
                    .frame(width: 150, alignment: .center)
                    .font(.system(size: 25))
                    .multilineTextAlignment(.center)
                }
                Spacer(minLength: 65)
                Button(action:{
                    viewModel.removeExercise(idf: idf)
                       }, label: {
                        Image(systemName: "xmark.circle.fill")
                        .symbolRenderingMode(.palette)
                        .resizable()
                        .foregroundStyle(.red,  Color(red: 60 / 255, green: 60 / 255, blue: 60 / 255))
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 25, height: 25)
                })
                Spacer(minLength: 5)
                
            }
             if let idx = viewModel.exercs.firstIndex(where: {$0.id == idf}){
                 ForEach($viewModel.exercs[idx].sets) { currSet in
                     VStack{
                         WeightSetterViewer(gymSet: currSet)
                         RepsViewer(gymSet: currSet)
                     }
                     .frame(width: 250, height: 100)
                     .background(Color(red: 60 / 255, green: 60 / 255, blue: 60 / 255))
                     .cornerRadius(20)
                        
                 
                 
                 }
             }
             

            HStack{
                Button(action:{
                    if(viewModel.getExercise(idf: idf).setAmt()>1){
                        //var currExercise: Exercise = viewModel.getExercise(idf: idf)
                        if let idx = viewModel.exercs.firstIndex(where: {$0.id == idf}){
                            viewModel.exercs[idx].removeLastSet()
                        }
                    }
                    }, label: {
                        Image(systemName: "minus.circle.fill")
                        .symbolRenderingMode(.palette)
                        .resizable()
                        .foregroundStyle(.red, .green, .black)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                })
                
                Text("set")
                    .bold()
                    .font(.system(size: 21))
                    .frame(width: 30, height: 50)
                    .multilineTextAlignment(.center)
            
                // plus button
                Button(action:{
                    //var currExercise: Exercise = viewModel.getExercise(idf: idf)
                    if let idx = viewModel.exercs.firstIndex(where: {$0.id == idf}){
                        let lastSet: GymSet = viewModel.exercs[idx].getLastSet()
                        viewModel.exercs[idx].addSet(weight: lastSet.weight, repAmt: lastSet.repAmt)
                        
                    }
                }, label: {
                    Image(systemName: "plus.circle.fill")
                    .symbolRenderingMode(.palette)
                    .resizable()
                    .foregroundStyle(.blue, .green, .black)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                                    
                })
                
            }
            .frame(width: 175, height: 65, alignment: .center)
            .background(LinearGradient(gradient: Gradient(colors: [.pink, .indigo]), startPoint: .leading, endPoint: .trailing)
                .edgesIgnoringSafeArea(.all))
            .cornerRadius(20)
        }
        .frame(width: 325, height: 450, alignment: .center)
        .background(.teal)
        .cornerRadius(20)
        

        
    }
}

//struct ExerciseViewer_Previews: PreviewProvider {
//    static var previews: some View {
//        ExerciseViewer(currExercise: Exercise(), idf: UUID())
//            .environmentObject(ExercisesViewModel())
//    }
//}
