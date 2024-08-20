//
//  ControlPanel.swift
//  LemonCountdown
//
//  Created by Lu Ai on 2024/8/19.
//

import HorizontalPicker
import LemonCountdownModel
import SwiftUI

let stickerPickerId = UUID()
let backgroundPickerId = UUID()

struct ControlPanel: View {
    
    @Binding var selectedControl: Control
    @Binding var selectedSticker: String
    @Binding var showInputText: Bool
    @Binding var selectedBackgroundKind: BackgroundKind

    init(selectedControl: Binding<Control>, selectedSticker: Binding<String>, showInputText: Binding<Bool>, selectedBackgroundKind: Binding<BackgroundKind>) {
        _selectedControl = selectedControl
        _selectedSticker = selectedSticker
        _showInputText = showInputText
        _selectedBackgroundKind = selectedBackgroundKind
        print("init")
    }

    var body: some View {
        switch selectedControl {
        case .sticker:
            HorizontalSelectionPicker(pickerId: stickerPickerId, items: stickerMap.keys.elements, selectedItem: $selectedSticker) { stickerName in
                Text(stickerName)
            }

        case .text:

            HStack {
                Spacer()
                Button {
                    showInputText = true
                } label: {
                    Text("输入文字")
                }
                .padding(.horizontal, 12)
//                .buttonStyle(HorizontalPickerButtonStyle(isSelected: true))
            }

        case .eventInfo:
            HStack {}
        case .background:
            HorizontalSelectionPicker(pickerId: backgroundPickerId, items: BackgroundKind.allCases, selectedItem: $selectedBackgroundKind) { backgroundKind in
                Text(backgroundKind.text).tag(backgroundKind)
            }
        }
    }
}

struct WeekdaySelectionView: View {
    static let weekdays = [
        "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日",
    ]

    @State private var selectedWeekday = WeekdaySelectionView.weekdays.first!

    var body: some View {
        HorizontalSelectionPicker(pickerId: UUID(), items: WeekdaySelectionView.weekdays, selectedItem: $selectedWeekday, backgroundColor: .clear) { weekday in
            Text(weekday)
        }
    }
}

// Preview
struct HorizontalPickerPreview: PreviewProvider {
    static var previews: some View {
        WeekdaySelectionView()
    }
}
