//
//  TextFrameSizeHelper.swift
//  CanvasEditor
//
//  Created by Lu Ai on 2024/8/21.
//

import Foundation
import UIKit

extension String {
    func size(usingUIFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return size(withAttributes: fontAttributes)
    }

    func widthOfString(usingUIFont font: UIFont) -> CGFloat {
        size(usingUIFont: font).width
    }

    func heightOfString(usingUIFont font: UIFont) -> CGFloat {
        size(usingUIFont: font).height
    }

    func heightOfStringBasedOnWidth(usingUIFont font: UIFont, width: CGFloat) -> CGFloat {
        let size = self.size(usingUIFont: font)
        guard size.width > width else { return size.height }

        let lineHeight = size.height
        let totalWidth = size.width
        let lineCount = ceil(totalWidth / width)

        return lineHeight * lineCount
    }
}
