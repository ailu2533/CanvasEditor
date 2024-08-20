//
//  IconSetPickerView.swift
//  CanvasEditor
//
//  Created by Lu Ai on 2024/8/20.
//

import SwiftUI

import Foundation
import SwiftUI
import HorizontalPicker

public struct SingleIconSetIconPickerView2: View {
    @State private var selectedIcon: String?
    private let icons: [String]
    private let columns = [GridItem(.adaptive(minimum: 70))]
    var tapCallback: (String) -> Void

    public init( icons: [String], tapCallback: @escaping (String) -> Void = { _ in }) {
//        _selectedIcon = selectedImg
        self.icons = icons
        self.tapCallback = tapCallback
    }

    public var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(icons, id: \.self) { image in
                        IconView(iconName: image)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(selectedIcon == image ? .blue.opacity(0.4) : .clear, style: StrokeStyle(lineWidth: 2, dash: [3]))
                                    .aspectRatio(contentMode: .fill)
                                    .padding(2)
                            )
                            .onTapGesture {
                                selectedIcon = image
                                tapCallback(image)
                            }
                    }
                }
                .sensoryFeedback(.selection, trigger: selectedIcon)
                .padding(.horizontal)
            }
        }
    }
}
