//
//  WidgetEditorToolbarContent.swift
//  LemonCountdown
//
//  Created by Lu Ai on 2024/8/19.
//

import LemonCountdownModel
import SwiftUI

struct WidgetEditorToolbarContent: ToolbarContent {
    let phase: WidgetPhase
    let saveAction: () -> Void

    @Environment(\.dismiss)
    private var dismiss

    init(phase: WidgetPhase, saveAction: @escaping () -> Void) {
        self.phase = phase
        self.saveAction = saveAction
    }

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button {
                // TODO:

            } label: {
                Label {
                    Text("保存")
                } icon: {
                    Image(systemName: "checkmark.circle")
                }
            }
        }
    }
}
