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
    @Bindable var phase: WidgetPhase
    let widgetSize: CGSize
    let widgetCenter: CGPoint
    let saveAction: (WidgetPhase) -> Void

    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.dismiss) private var dismiss
    @State private var editorViewModel = WidgetPhaseEditorViewModel()

    private let bottomPanelHeight = 264.0

    init(phase: WidgetPhase, widgetSize: CGSize, saveAction: @escaping (WidgetPhase) -> Void) {
        self.phase = phase
        self.widgetSize = widgetSize
        widgetCenter = CGPoint(x: widgetSize.width / 2, y: widgetSize.height / 2)
        self.saveAction = saveAction
    }

    var body: some View {
        NavigationStack {
            GeometryReader { _ in
                VStack {
                    Spacer()
                    WidgetPhaseEditorCardView(phase: phase, widgetSize: widgetSize, selection: $editorViewModel.selection)
                    Spacer()
                    WidgetEditorControlsView(phase: phase, vm: editorViewModel, height: bottomPanelHeight)
                }
                .ignoresSafeArea(.keyboard)
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
        .onAppearOnce {
            editorViewModel.configure(phase: phase, widgetCenter: widgetCenter)
        }
        .onChange(of: editorViewModel.selection) { oldValue, newValue in
            editorViewModel.updateSelectionDetails(oldValue, newValue)
        }
    }

    @ViewBuilder
    private var textInputAlert: some View {
        TextField("", text: $editorViewModel.text)
        Button("取消", role: .cancel) { }
        Button("确定", action: editorViewModel.addTextItem)
    }
}
