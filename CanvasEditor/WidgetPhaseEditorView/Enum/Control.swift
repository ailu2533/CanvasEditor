//
//  Control.swift
//  LemonCountdown
//
//  Created by Lu Ai on 2024/8/19.
//

import Foundation
import HorizontalPicker
import LemonCountdownModel
import SwiftMovable
import SwiftUI

enum Control: Int, Hashable, CaseIterable {
    case sticker
    case text
    case background
    case eventInfo

    var text: LocalizedStringKey {
        switch self {
        case .background: return "背景"
        case .sticker: return "贴纸"
        case .text: return "文字"
        case .eventInfo: return "事件信息"
        }
    }

    @ViewBuilder
    func view(vm: WidgetPhaseEditorViewModel, phase: WidgetPhase) -> some View {
        @Bindable var vm = vm

        switch self {
        case .background:
            BackgroundPickerView(selectedBackgroundKind: vm.selectedBackgroundKind, background: phase.background)
        case .sticker:
            SingleIconSetIconPickerView2(icons: stickerMap[vm.selectedStickerPack] ?? [], tapCallback: vm.addSticker)
        case .text:

            if let textItem = (vm.selection as? TextItem) {
                TextStyleEditor(textItem: textItem)
            } else {
                TextStyleEditor(textItem: .init(text: ""))
            }

        case .eventInfo:
            EventInfoPickerView(tapCallback: vm.addEventInfo, wigetPhaseTimeKind: phase.kind)
        }
    }
}
