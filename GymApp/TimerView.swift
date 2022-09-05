//
//  TimerView.swift
//  Gymhelper
//
//  Created by Magnus Müller on 29.08.22.
//

import SwiftUI

struct TimerButton: View {
    
    let label: String
    let buttonColor: Color
    
    var body: some View {
        Text(label)
            .foregroundColor(.white)
            .padding(.vertical, 20)
            .padding(.horizontal, 90)
            .background(buttonColor)
            .cornerRadius(10)
    }
}

struct MultiPicker: View  {

    typealias Label = String
    typealias Entry = String

    let data: [ (Label, [Entry]) ]
    @Binding var selection: [Entry]

    var body: some View {
        GeometryReader { geometry in
            HStack {
                ForEach(0..<self.data.count) { column in
                    Picker(self.data[column].0, selection: self.$selection[column]) {
                        ForEach(0..<self.data[column].1.count) { row in
                            Text(verbatim: self.data[column].1[row])
                            .tag(self.data[column].1[row])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: geometry.size.width / CGFloat(self.data.count), height: geometry.size.height)
                    .clipped()
                }
            }
        }
    }
}

struct TimerView: View {
    
    @State var data: [(String, [String])] = [
           ("One", Array(0...60).map { "\($0)" }),
           ("Two", Array(0...60).map { "\($0)" })
           //("Three", Array(100...200).map { "\($0)" })
       ]
    @State var selection: [String] = [0, 0].map { "\($0)" }

    
    @ObservedObject var stopWatchManager = StopWatchManager()
    @State var selectedTime: Int = 0
    
    func calcCurrTime()-> Double{
        return (Double(selection[0]) ?? 0)*60+(Double(selection[1]) ?? 0)-stopWatchManager.secondsElapsed
    }
    
    func timeFormating(currTime:Double) -> String{
        let currMin: Int = Int(Int(floor(currTime)) / 60)
        let currSec: Double = currTime - Double(currMin*60)
        return String(currMin)+":"+String(format: "%.1f", currSec)
    }
    

    var body: some View {
            VStack {
               
                if stopWatchManager.mode == .stopped {
                    MultiPicker(data: data, selection: $selection)
                        .frame(height: 300)
                        .frame(width: 300)
                    Button(action: {self.stopWatchManager.start()}) {
                        TimerButton(label: "Start", buttonColor: .blue)
                    }
                }
                else if stopWatchManager.mode == .running {
                    let currTime: Double = calcCurrTime()
                    let timeDisplay: String = timeFormating(currTime: currTime)
                    
                    if currTime < 0 {
                        //self.stopWatchManager.stop()
                    } else{
                        Text(timeDisplay)
                            .font(.custom("Avenir", size: 40))
                            .frame(width: 250, height: 75, alignment: .center)
                            .padding(25)
                            .onDisappear{
                                if(stopWatchManager.mode != .paused){
                                    stopWatchManager.stop()
                                }
                            }
                        Button(action: {self.stopWatchManager.pause()}) {
                            TimerButton(label: "Pause", buttonColor: .blue)
                            .frame(width: 250, height: 75, alignment: .center)
                            .padding(.bottom, 75)

                        }
                    }
                }
                else if stopWatchManager.mode == .paused {
                    let currTime: Double = calcCurrTime()
                    let timeDisplay: String = timeFormating(currTime: currTime)

                    if currTime < 0 {}
                    else{
                        Text(timeDisplay)
                            .font(.custom("Avenir", size: 40))
                            .padding(25)
                            //.padding(.bottom, 100)
                           
                        Button(action: {self.stopWatchManager.start()}) {
                            TimerButton(label: "Start", buttonColor: .blue)
                                .frame(width: 250, height: 75, alignment: .center)
                                .padding(25)
                        }
                        Button(action: {self.stopWatchManager.stop()}) {
                            TimerButton(label: "Stop", buttonColor: .red)
                        }
                        .frame(width: 250, height: 75, alignment: .center)
                        .padding(.bottom, 75)
                    }
            
                }
            }
            Spacer()

        }
}

struct TimerView_Previews: PreviewProvider {
    //@State var currTime = 0
    static var previews: some View {
        TimerView()
        
    }
}
