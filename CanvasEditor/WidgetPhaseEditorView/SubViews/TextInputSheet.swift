//
//  TextInputSheet.swift
//  CanvasEditor
//
//  Created by Lu Ai on 2024/8/21.
//

import SwiftUI

struct TextInputSheet: View {
    @State private var text = "双击编辑文字"
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        VStack {
            TextField(text: $text) {
                Text("文案")
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    dismiss()
                }, label: {
                    Text("关闭")
                })
            }
        }
       
    }
}

#Preview {
    TextInputSheet()
}
