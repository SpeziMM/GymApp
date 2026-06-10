//
//  ContentView.swift
//  Gymhelper
//
//  Created by Magnus Müller on 18.08.22.
//
import SwiftUI

struct ContentView: View {
    /// stores the workout data
    @ObservedObject var viewModel: WorkoutViewModel
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        TabView {
            ZStack{
                BackgroundView()
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(viewModel.exercs){ exercise in
                            ExerciseViewer(idf: exercise.id)
                                .environmentObject(viewModel)
                        }

                        addExerciseButton(viewModel: viewModel)
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 24)
                }
            }
            .onChange(of: scenePhase) { newPhase in
                if newPhase == .background {
                    viewModel.save()
                }
            }
            .onDisappear {
                viewModel.save()
            }
            .tabItem {
                Label("Workout", systemImage: "list.bullet.rectangle.portrait")
            }

            ZStack{
                BackgroundView()
                VStack{
                    TimerView()
                        .frame(width: 300, height: 200, alignment: .topLeading)
                }
            }
            .tabItem {
                Label("Timer", systemImage: "timer")
            }
        }
    }
    
}

//struct ContentView_Previews: PreviewProvider {
//
//    static var previews: some View {
//        ContentView(viewModel: .constant(viewModel))
//    }
//}

// simple view to make a gradient background
struct BackgroundView: View{
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [Color(red: 0.96, green: 0.97, blue: 0.98), Color(red: 0.99, green: 0.99, blue: 1.0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

// "add exercise" tile that matches the exercise cards and scrolls with the content
struct addExerciseButton: View{
    @ObservedObject var viewModel: WorkoutViewModel
    var body: some View{
        Button(action:{
            viewModel.addExercise()
        }, label: {
            HStack(spacing: 10) {
                Image(systemName: "plus.circle.fill")
                    .font(.title2)
                    .foregroundColor(.green)
                Text("Add exercise")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 20)
            .background(
                RoundedRectangle(cornerRadius: 22)
                    .fill(Color(red: 0.98, green: 0.98, blue: 0.99).opacity(0.7))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .strokeBorder(Color.green.opacity(0.45),
                                  style: StrokeStyle(lineWidth: 1.5, dash: [6, 5]))
            )
            .padding(.horizontal, 8)
        })
        .buttonStyle(.plain)
    }
}

// button to navigate to a view that shows workout data
struct navigationWorkoutButton: View{
    @Binding var isHome: Bool
    var body: some View{
            Button(action:{
                isHome = true
            }, label: {
                Image(systemName: "list.bullet.rectangle.portrait")
                .symbolRenderingMode(.palette)
                .resizable()
                //.foregroundStyle(.red,.blue,.blue)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                                
            })
             .frame(alignment: .center)
    }
}

// button to navigatge to a view that shows a timer
struct navigationButtonTimer: View{
    @Binding var isHome: Bool
    //@ObservedObject var viewModel: ExercisesViewModel
    var body: some View{
            Button(action:{
                isHome = false
            }, label: {
                Image(systemName: "timer")
                .symbolRenderingMode(.palette)
                .resizable()
                //.foregroundStyle(.blue, .red, .black)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                                
            })
             .frame(alignment: .center)
    }
}
