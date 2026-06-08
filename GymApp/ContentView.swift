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
    
    var body: some View {
        TabView {
            ZStack{
                BackgroundView()
                VStack{
                    Spacer(minLength: 30)
                    ScrollView {
                        ForEach(viewModel.exercs){exercise in
                            ExerciseViewer(idf: exercise.id).environmentObject(viewModel)
                        }
                    }
                    .cornerRadius(20)
                    Spacer(minLength: 25)
                    addExerciseButton(viewModel: viewModel)
                        .padding(.bottom)
                }
            }
            .padding(.top)
            .cornerRadius(20)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification), perform: { _ in
                viewModel.save()
            })
            .onDisappear {
                viewModel.save()
            }
            .tabItem {
                Label("Workout", systemImage: "list.bullet.rectangle.portrait")
            }

            ZStack{
                BackgroundView()
                VStack{
                    Spacer(minLength: 20)
                    TimerView()
                        .frame(width: 300, height: 200, alignment: .topLeading)
                    Spacer(minLength: 20)
                }
            }
            .tabItem {
                Label("Timer", systemImage: "timer")
            }
        }
        .background(.black)
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
        LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing)
            .edgesIgnoringSafeArea(.all)
    }
}

// button that adds exercise to current workout
struct addExerciseButton: View{
    @ObservedObject var viewModel: WorkoutViewModel
    var body: some View{
            Button(action:{
                viewModel.addExercise()
            }, label: {
                Image(systemName: "note.text.badge.plus")
                .symbolRenderingMode(.palette)
                .resizable()
                .foregroundStyle(.blue, .green, .black)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                                
            })
             .frame(alignment: .center)
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
