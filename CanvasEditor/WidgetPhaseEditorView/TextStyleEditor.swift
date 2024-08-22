//
//  MovableTextEditor.swift
//  LemonEvent
//
//  Created by ailu on 2024/5/10.
//

import HorizontalPicker
import LemonCountdownModel
import SwiftMovable
import SwiftUI

struct TextStyleEditor: View {
    @Bindable var textItem: TextItem

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
        Slider(value: Binding(get: {
            textItem.fontSize
        }, set: { fontSize in
            textItem.fontSize = fontSize
            let frameSize = textItem.text.size(usingUIFont: .systemFont(ofSize: fontSize))
            textItem.height = frameSize.height
            textItem.width = frameSize.width

        }), in: 1 ... 100, step: 1)
    }

    private var fontNamePicker: some View {
        ComparableHorizontalSelectionPicker(items: CustomFont.fonts, selectedItem: Binding(get: {
            CustomFont(displayName: "", postscriptName: textItem.fontName ?? "")
        }, set: { newFontName in
            textItem.fontName = newFontName.postscriptName
        })) { fontName in
            Text("字体").font(.custom(fontName.postscriptName, size: 15))
                .frame(height: 24)
        }
    }

    private var colorPicker: some View {
        ComparableHorizontalSelectionPicker(items: ColorSets.textColors, selectedItem: Binding(get: {
            textItem.colorHex
        }, set: { newColor in
            textItem.colorHex = newColor
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
