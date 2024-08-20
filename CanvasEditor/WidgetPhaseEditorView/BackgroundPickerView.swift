//
//  BackgroundPickerView.swift
//  LemonCountdown
//
//  Created by Lu Ai on 2024/8/19.
//

import LemonCountdownModel
import SwiftUI

// View for selecting a background color or gradient for the phase.
struct BackgroundPickerView: View {
    var selectedBackgroundKind: BackgroundKind
    @Bindable var background: Background

    var body: some View {
        switch selectedBackgroundKind {
        case .morandiColors:
            ColorPickerView(selection: backgroundColorBinding, colorSet: ColorSets.morandiColors)
        case .macaronColors:
            ColorPickerView(selection: backgroundColorBinding, colorSet: ColorSets.macaronColors)
        case .linearGredient:
            LinearGradientPicker(selection: linearGradientBinding)
        }
    }

    private var backgroundColorBinding: Binding<String?> {
        Binding(
            get: { background.backgroundColor },
            set: { newColor in
                background.kind = selectedBackgroundKind
                background.backgroundColor = newColor
            }
        )
    }

    private var linearGradientBinding: Binding<[String]> {
        Binding(
            get: { background.linearGradient ?? [] },
            set: { newColors in
                background.kind = .linearGredient
                background.linearGradient = newColors
            }
        )
    }
}
