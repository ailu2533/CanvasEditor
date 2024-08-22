//
//  WidgetPhaseEditorViewModel.swift
//  LemonCountdown
//
//  Created by Lu Ai on 2024/8/19.
//

import Foundation
import LemonCountdownModel
import SwiftMovable
import UIKit

@Observable
class WidgetPhaseEditorViewModel {
    // MARK: - 属性

    var selection: MovableObject?
    var selectedControl: Control = .background
    var selectedBackgroundKind = BackgroundKind.linearGredient
    var selectedFontName: String?
    var fontSize: CGFloat = 20
    var selectedStickerPack: String = stickerMap.keys.elements.first ?? ""

    var showInputText = false
    var text = ""

    private(set) var phase: WidgetPhase!
    private(set) var widgetCenter: CGPoint!
//
//    // MARK: - 初始化方法
//
    func configure(phase: WidgetPhase, widgetCenter: CGPoint) {
        self.phase = phase
        self.widgetCenter = widgetCenter
    }

    func addTextItem() {
        let textItem = TextItem(text: text, pos: widgetCenter)
        textItem.colorHex = "#2f261e"
        textItem.width = text.widthOfString(usingUIFont: .systemFont(ofSize: 25))
        textItem.height = text.heightOfString(usingUIFont: .systemFont(ofSize: 25))

        phase.texts.append(textItem)
        selection = textItem
        text = ""
    }

    // Saves the model when the view disappears or the scene phase changes.
    func saveWidgetTemplateModel() {
//        Logging.openUrl.debug("saveWidgetTemplateModel: TODO")
//
//        if let model = widgetTemplate.getWidgetTemplateModel() {
//            if model.modelContext == nil {
//                print("insert Model")
//                modelContext.insert(model)
//            }
//
//            if model.isDeleted {
//                return
//            }
//
//            model.jsonData = WidgetTemplateModel.encodeWidgetTemplate(widgetTemplate)
//            Logging.openUrl.debug("jsonData: \(model.jsonData)")
        ////            Logging.openUrl.debug("saveWidgetTemplateModel: \(model.title) \(model.uuid) template: \(widgetTemplate.hashValue)")
//
//            // TODO: 优化
//            WidgetCenter.shared.reloadAllTimelines()
//        }
    }

    // Adds a sticker to the phase when selected.
    func addSticker(_ iconName: String) {
        let image = MovableSticker(stickerName: iconName, pos: widgetCenter)
        phase.stickers.append(image)
        selection = image
    }

    func addEventInfo(_ eventInfo: EventInfoKind) {
        let (fontName, fontSize) = getFontSettings(for: eventInfo)
        let eventInfo = EventInfo(eventInfo: eventInfo, eventInfoProvider: phase.getEventInfoProvider(), position: widgetCenter, fontName: fontName, fontSize: fontSize)
        phase.eventInfo.append(eventInfo)
        selection = eventInfo
    }

    // Handles the change in selected control and creates a new text item if needed.
    func handleTextSelectionChange(oldValue: Control, newValue: Control) {
        if oldValue != .text && newValue == .text && selection as? TextItem == nil {
            createAndSelectNewTextItem()
        }
    }

    // Updates the selection details based on the selected object.
    func updateSelectionDetails(_ oldValue: MovableObject?, _ newValue: MovableObject?) {
        guard let newValue = newValue else { return }
        selectedControl = switch newValue {
        case is TextItem: .text
        case is MovableSticker: .sticker
        default: selectedControl
        }
    }

    // Creates and selects a new text item when needed.
    func createAndSelectNewTextItem() {
        let textItem = TextItem(text: String(localized: "双击编辑文案"), pos: widgetCenter)
        phase.texts.append(textItem)
        selection = textItem
    }

    // MARK: - 私有方法

    private func getFontSettings(for eventInfo: EventInfoKind) -> (String?, CGFloat) {
        let defaultFontName = "ChillRoundFRegular"
        let defaultFontSize: CGFloat = 20

        switch eventInfo {
        case .eventTitle:
            return (defaultFontName, 25)
        case .currentWeekDay:
            return (defaultFontName, 20)
        default:
            return (defaultFontName, defaultFontSize)
        }
    }
}
