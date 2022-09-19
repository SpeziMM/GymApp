//
//  RepsViewer.swift
//  Gymhelper
//
//  Created by Magnus Müller on 23.08.22.
//

import SwiftUI
// View to select Rep Amount
struct RepsViewer: View{
    @Binding var gymSet: GymSet
    var body: some View{
        HStack {
            Text("\(Image(systemName: "repeat"))")
            Picker(selection: $gymSet.repAmt, label: Text("Picker")) {
                ForEach((1...15), id: \.self) {
                    Text("\($0)").tag($0)
                        .font(.system(size: 30))
                }
               
            }
        }
    }
    
}

//struct RepsViewer_Previews: PreviewProvider {
//    static var previews: some View {
//        RepsViewer(gymSet: GymSet())
//            .previewLayout(.sizeThatFits)
//    }
//}
