//
//  WidgetCardView3.swift
//  LemonCountdown
//
//  Created by Lu Ai on 2024/8/19.
//

import LemonCountdownModel
import SwiftMovable
import SwiftUI

// New subviews
struct WidgetPhaseEditorCardView: View {
    let phase: WidgetPhase
    let widgetSize: CGSize
    @Binding var selection: MovableObject?

    init(phase: WidgetPhase, widgetSize: CGSize, selection: Binding<MovableObject?>) {
        self.phase = phase
        self.widgetSize = widgetSize
        _selection = selection
    }

    var body: some View {
        ZStack {
            Color(.systemBackground)
                .onTapGesture {
                    selection = nil
                }
            EditableWidgetCardView(model: phase, widgetSize: widgetSize, selection: $selection)
        }
    }
}
