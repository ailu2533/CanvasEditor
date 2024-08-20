//
//  CatWidget.swift
//  LemonEvent
//
//  Created by ailu on 2024/5/5.
//

import HorizontalPicker
import LemonCountdownModel
import PagerTabStripView
import SwiftMovable
import SwiftUI
import SwiftUIX

// Represents a phase of the widget editing process.
struct WidgetPhaseEditorView: View {
    // Represents a phase of the widget editing process.
    @Bindable var phase: WidgetPhase

    // Size of the widget being edited.
    let widgetSize: CGSize
    // Center point of the widget for positioning elements.
    let widgetCenter: CGPoint
    // Fixed height for the bottom panel.
    let height = 264.0

    init(phase: WidgetPhase, widgetSize: CGSize) {
        self.widgetSize = widgetSize
        widgetCenter = .init(x: widgetSize.width / 2, y: widgetSize.height / 2)

        Logging.openUrl.debug("WidgetPhaseEditorView init ")

        self.phase = phase
    }

    // Environment variables for managing app state and interactions.
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismiss) private var dismiss

    @State private var editorViewModel = WidgetPhaseEditorViewModel()

    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                VStack {
                    Spacer()
                    WidgetPhaseEditorCardView(phase: phase, widgetSize: widgetSize, selection: $editorViewModel.selection)
                    Spacer()
                    WidgetEditorControlsView(phase: phase, vm: editorViewModel, height: height)
                }.ignoresSafeArea(.keyboard)
            }
            .toolbar {
                WidgetEditorToolbarContent(phase: phase, saveAction: editorViewModel.saveWidgetTemplateModel)
            }
        }
        .ignoresSafeArea(.all, edges: .bottom)
        .onDisappear(perform: editorViewModel.saveWidgetTemplateModel)
        .onChange(of: scenePhase) { _, _ in
            // TODO:
        }
        .alert("输入文字", isPresented: $editorViewModel.showInputText) {
            textInputAlert
        }
        .onChange(of: editorViewModel.selection, perform: editorViewModel.updateSelectionDetails)
        .onAppearOnce {
            editorViewModel.configure(phase: phase, widgetCenter: widgetCenter)
        }
    }

    @ViewBuilder
    private var textInputAlert: some View {
        TextField("", text: $editorViewModel.text)
        Button("取消", role: .cancel) { }
        Button("确定", action: editorViewModel.addTextItem)
    }
}
