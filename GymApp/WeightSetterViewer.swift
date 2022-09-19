//
//  WeightSetterViewer.swift
//  Gymhelper
//
//  Created by Magnus Müller on 23.08.22.
//

import SwiftUI

struct WeightSetterViewer: View{
    /// current selected Set
    @Binding var gymSet: GymSet
    let weight_increase: Double = 0.25
    /// time in 100ms after which increase get accelerated -> the longer u holt button -> the faster weight gets increased
    let timeIncreaseSpeed: Int8 = 5
    /// maximum possible weight
    let maxWeight: Double = 500.0
    /// timer to differentiate long and short press on button
    @State private var timer: Timer?
    /// state to detect if button was pressed long
    @State var isLongPressing = false
    /// string for displaying weight in KG
    @State var helperString: String  = "20.0 KG"
    var body: some View{
        HStack{
            // minus button
            Button(action:{
                //this tap was caused by the end of a longpress gesture, so stop our fastforwarding
                if(self.isLongPressing){
                    self.isLongPressing.toggle()
                    self.timer?.invalidate()
         
                // normal press
                }else{
                    let helper: Double = (Double(gymSet.weight) ?? 0) - weight_increase >= 0 ? (Double(gymSet.weight) ?? 0) - weight_increase : 0
                    gymSet.weight = String(format: "%.2f", helper)
                    helperString = "\(gymSet.weight) \("KG")"
                    }
                }, label: {
                    Image(systemName: "minus.circle.fill")
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    
            }) // long press
            .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded { _ in
                self.isLongPressing = true
                var increaseSpeed: Double = 0
                var counter: Int8 = timeIncreaseSpeed
                //or fastforward has started to start the timer
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                    let helper: Double = (Double(gymSet.weight) ?? 0) - (weight_increase+increaseSpeed) >= 0 ? (Double(gymSet.weight) ?? 0) - (weight_increase+increaseSpeed): 0
                    gymSet.weight = String(format: "%.2f", helper)
                    helperString = "\(gymSet.weight) \("KG")"
                    counter = counter-1 >= 0 ? counter-1: timeIncreaseSpeed
                    if(counter == 0){
                        increaseSpeed += 0.25
                    }
                })
                
            })
            HStack(spacing: 5) {
                TextFieldDynamicWidth(title: "dont giva fuck!", text: $gymSet.weight) { editingChange in
                // logic
              } onCommit: {
                // logic
              }.font(.title).multilineTextAlignment(.center)
              Text("KG")
                    .foregroundColor(.blue)
            }
          
        
            
            // plus button
            Button(action:{
                //this tap was caused by the end of a longpress gesture, so stop our fastforwarding
                if(self.isLongPressing){
                    self.isLongPressing.toggle()
                    self.timer?.invalidate()
                // normal press
                }else{
                    let helper: Double = (Double(gymSet.weight) ?? 0) + weight_increase <= maxWeight ? (Double(gymSet.weight) ?? 0) + weight_increase: maxWeight
                    gymSet.weight = String(format: "%.2f", helper)
                    helperString = "\(gymSet.weight) \("KG")"
                    }
                }, label: {
                Image(systemName: "plus.circle.fill")
                .symbolRenderingMode(.palette)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(.white, .green, .blue)
                .frame(width: 50, height: 50)
            })
            .simultaneousGesture(LongPressGesture(minimumDuration: 0.2).onEnded { _ in
                self.isLongPressing = true
                var increaseSpeed: Double = 0
                var counter: Int8 = timeIncreaseSpeed
                //or fastforward has started to start the timer
                self.timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
                    let helper: Double = (Double(gymSet.weight) ?? 0) + (weight_increase+increaseSpeed) <= maxWeight ? (Double(gymSet.weight) ?? 0) + (weight_increase+increaseSpeed): maxWeight
                    gymSet.weight = String(format: "%.2f", helper)
                    helperString = "\(gymSet.weight) \("KG")"
                    counter = counter-1 >= 0 ? counter-1: timeIncreaseSpeed
                    if(counter == 0){
                        increaseSpeed += 0.25
                    }

                })
            })
        }
       
    }
             
}

struct WeightSetterViewer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeightSetterViewer(gymSet: .constant(GymSet()))
                .previewLayout(.sizeThatFits)
        }
    }
}
