//
//  SwiftUIView.swift
//
//
//  Created by ailu on 2024/4/18.
//

import SwiftUI

//public struct ColorPickerView: View {
//    @Binding private var selectedColor: String
//    private let colorSet: [String]
//    private let rows = Array(repeating: GridItem(.fixed(50)), count: 4)
//    private let defaultColor = Color.blue
//
//    public init(selection: Binding<String>, colorSet: [String]) {
//        _selectedColor = selection
//        self.colorSet = colorSet
//    }
//
//    public var body: some View {
//        ScrollView(.horizontal) {
//            LazyHGrid(rows: rows) {
//                ForEach(colorSet, id: \.self) { colorHex in
//                    let color = Color(uiColor: UIColor(hex: colorHex) ?? UIColor.blue)
//                    Circle()
//                        .fill(color)
//                        .scaleEffect(selectedColor == colorHex ? 0.8 : 1)
//                        .overlay(Circle().stroke(color, lineWidth: selectedColor == colorHex ? 2 : 0))
//                        .onTapGesture {
//                            selectedColor = colorHex
//                        }
//                        .padding(2)
//                }
//            }
//            .sensoryFeedback(.selection, trigger: selectedColor)
//        }
//        .scrollIndicators(.hidden)
//        .scrollContentBackground(.hidden)
//    }
//}

public struct ColorPickerView: View {
    @Binding private var selectedColor: String?
    private let colorSet: [String]
    private let columns = [GridItem(.adaptive(minimum: 40, maximum: 60))]
    private let defaultColor = Color.blue

    public init(selection: Binding<String?>, colorSet: [String]) {
        _selectedColor = selection
        self.colorSet = colorSet
    }

    public var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(colorSet, id: \.self) { colorHex in
                        let color = Color(uiColor: UIColor(hex: colorHex) ?? UIColor.blue)
                        Circle()
                            .fill(color)
                            .scaleEffect(selectedColor == colorHex ? 0.8 : 1)
                            .overlay(Circle().stroke(color, lineWidth: selectedColor == colorHex ? 2 : 0))
                            .onTapGesture {
                                selectedColor = colorHex
                            }
                            .padding(2)
                    }
                }
                .sensoryFeedback(.selection, trigger: selectedColor)
            }
            .scrollIndicators(.hidden)
            .scrollContentBackground(.hidden)
        }.padding(.horizontal)
//            .padding(.top)
    }
}
