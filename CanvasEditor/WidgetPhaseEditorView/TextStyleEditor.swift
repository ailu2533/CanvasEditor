//
//  MovableTextEditor.swift
//  LemonEvent
//
//  Created by ailu on 2024/5/10.
//

import HorizontalPicker
//import LemonUtils
import SwiftMovable
import SwiftUI
import LemonCountdownModel

struct TextStyleEditor: View {
    @Binding var textItem: Stylable?
    @State private var showFontSheet = false
    @Binding var selectedFontName: String?
    @Binding var fontSize: CGFloat

    @State private var fontDisplayName = "默认字体"

    var body: some View {
        ScrollView(.vertical) {
            Group {
                fontSizePicker
                colorPicker
                fontNamePicker
            }
            .listRowBackground(Color.clear)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets()) // Set insets to zero
        }.scrollDisabled(true)
//        .listStyle(PlainListStyle()) // Use PlainListStyle to reduce extra padding and separators
    }

    private var fontSizePicker: some View {
        ComparableHorizontalSelectionPicker(items: [15, 20, 25, 35, 45, 55, 65, 80, 90, 100], selectedItem: Binding(get: {
            textItem?.fontSize ?? 15
        }, set: { newSize in
            textItem?.fontSize = newSize
        })) { size in
            Text("\(Int(size))")
                .frame(height: 24)
        }
    }

    private var fontNamePicker: some View {
        ComparableHorizontalSelectionPicker(items: CustomFont.fonts, selectedItem: Binding(get: {
            CustomFont(displayName: "", postscriptName: textItem?.fontName ?? "")
        }, set: { newFontName in
            textItem?.fontName = newFontName.postscriptName
        })) { fontName in
            Text("字体").font(.custom(fontName.postscriptName, size: 15))
                .frame(height: 24)
        }
    }

    private var colorPicker: some View {
        ComparableHorizontalSelectionPicker(items: ColorSets.textColors, selectedItem: Binding(get: {
            textItem?.colorHex ?? ColorSets.textColors.first!
        }, set: { newColor in
            textItem?.colorHex = newColor
        })) { color in
            Circle().fill(Color(uiColor: UIColor(hex: color) ?? UIColor.blue)).frame(width: 24)
        }
    }
}

// struct FontColors {
//    static let rainbow: [Color] = [
//        .black, .red, .orange, .yellow, .green, .blue, .indigo, .purple, .white,
//    ]
// }
