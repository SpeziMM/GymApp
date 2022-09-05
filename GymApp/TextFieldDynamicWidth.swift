//
//  TextFieldDynamicWidth.swift
//  Gymhelper
//
//  Created by Magnus Müller on 26.08.22.
//

import SwiftUI

struct TextFieldDynamicWidth: View {
    let title: String
    @Binding var text: String
    let onEditingChanged: (Bool) -> Void
    let onCommit: () -> Void
    
    @State private var textRect = CGRect()
    
    var body: some View {
        ZStack {
            Text(text == "" ? title : text).background(GlobalGeometryGetter(rect: $textRect)).layoutPriority(1).opacity(0)
            HStack {
                TextField(title, text: $text, onEditingChanged: onEditingChanged, onCommit: onCommit)
                .frame(width: textRect.width)
                .foregroundColor(.blue)
            }
        }
    }
}

struct GlobalGeometryGetter: View {
    @Binding var rect: CGRect

    var body: some View {
        return GeometryReader { geometry in
            self.makeView(geometry: geometry)
        }
    }

    func makeView(geometry: GeometryProxy) -> some View {
        DispatchQueue.main.async {
            self.rect = geometry.frame(in: .global)
        }

        return Rectangle().fill(Color.clear)
    }
}

struct TextFieldDynamicWidth_Previews: PreviewProvider {
    static var previews: some View {
        HStack(spacing: 10) {
            TextFieldDynamicWidth(title: "put some weight on!", text: .constant("20.00")) { editingChange in
            // logic
          } onCommit: {
            // logic
          }.font(.title).multilineTextAlignment(.center)
          Text("KG")
        }
    }
}
