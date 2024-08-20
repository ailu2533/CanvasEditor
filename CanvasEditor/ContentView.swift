//
//  ContentView.swift
//  CanvasEditor
//
//  Created by Lu Ai on 2024/8/20.
//

import LemonCountdownModel
import SwiftUI

struct ContentView: View {
    @State private var phase = WidgetPhase(kind: .taskEndDateAfter, eventInfoProvider: nil)

    @State private var vm = WidgetPhaseEditorViewModel()

    var body: some View {
        VStack {
            WidgetPhaseEditorView(phase: phase, widgetSize: .init(width: 300, height: 300)) { _ in }
        }
    }
}

#Preview {
    ContentView()
}
