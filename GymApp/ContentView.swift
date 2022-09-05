//
//  ContentView.swift
//  Gymhelper
//
//  Created by Magnus Müller on 18.08.22.
//
import SwiftUI

struct Exercise: Identifiable, Codable{
    var id: UUID = UUID()
    //var idx: Int
    var name: String = "Exercise"
    var sets: [GymSet] = [GymSet(),GymSet()]
    
    func setAmt() -> Int{
        return sets.count

    }
    func getName() -> String{
        return name
    }
    func getLastSet() -> GymSet{
        if(self.setAmt()>0){
            return sets[self.setAmt()-1]
        }
        return GymSet()
    }
    
    
    mutating func removeLastSet() {
        sets.remove(at: sets.count-1)
    }
    // add a Set with default values
    mutating func addSet(weight: String?,repAmt: Int?) {
        sets.append(GymSet(weight: weight ?? "20.00", repAmt: repAmt ?? 8))
    }
    // default reps
    
}

struct GymSet: Identifiable, Codable {
    var id = UUID()
    var weight: String = "20.00"
    var repAmt : Int = 8
}

class ExercisesViewModel: ObservableObject {
    @Published var exercs: [Exercise]
    init(){
        if let data = UserDefaults.standard.data(forKey: "savedData"){
            if let decoded = try? JSONDecoder().decode([Exercise].self, from: data){
                exercs = decoded
                return
            }
        }
        exercs = [Exercise()]
    }
    func save(){
        if let encoded = try? JSONEncoder().encode(exercs){
            UserDefaults.standard.set(encoded,forKey: "savedData")
        }
        
    }
    
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


//@Binding var exercises: [Int] = [1,2]


struct ContentView: View {
    @ObservedObject var viewModel = ExercisesViewModel()
    @State var isHome = true
    
    var body: some View {
        VStack{
            if(isHome){
            ZStack{
                BackgroundView()
                VStack{
                    Spacer(minLength: 30)
                    ScrollView {
                        ForEach(viewModel.exercs){exercise in
                            if(viewModel.exercs.isEmpty){
                            }else{
                                ExerciseViewer(currExercise: exercise ,idf: exercise.id).environmentObject(viewModel)
                            }
                            
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
                .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification), perform: { output in
                    viewModel.save()
                        
                })
            } else {
                ZStack{
                    BackgroundView()
                    VStack{
                        Spacer(minLength: 20)
                        TimerView()
                            .frame(width: 300, height: 200, alignment: .topLeading)
                        Spacer(minLength: 20)

                    }
                }
            }
            Spacer(minLength: 10)

            HStack{
                navigationButton(isHome: $isHome)
                    .padding(.trailing)
                navigationButtonTimer(isHome: $isHome)
                    .padding(.leading)

                //navigationButton()
                //navigationButton()
            }
            Spacer(minLength: 20)

            
        }
        .background(.black)
        
    
    
    }
  
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BackgroundView: View{
    var body: some View{
        LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .leading, endPoint: .trailing)
            .edgesIgnoringSafeArea(.all)
    }
}

struct addExerciseButton: View{
    @ObservedObject var viewModel: ExercisesViewModel
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

struct navigationButton: View{
    @Binding var isHome: Bool
    //@ObservedObject var viewModel: ExercisesViewModel
    var body: some View{
            Button(action:{
                isHome = true
            }, label: {
                Image(systemName: "house")
                .symbolRenderingMode(.palette)
                .resizable()
                //.foregroundStyle(.green, .green, .black)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50, height: 50)
                                
            })
             .frame(alignment: .center)
        
    }
  
}

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

