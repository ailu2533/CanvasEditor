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
        return self.size(withAttributes: fontAttributes)
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

    func calculateMinimumFontSize(forSize targetSize: CGSize, fontName: String) -> CGFloat {
        let minFontSize: CGFloat = 1
        let maxFontSize: CGFloat = 100
        var low: Int = Int(minFontSize)
        var high: Int = Int(maxFontSize)
        
        while low < high {
            let mid = (low + high) / 2
            let font = UIFont(name: fontName, size: CGFloat(mid)) ?? UIFont.systemFont(ofSize: CGFloat(mid))
            let size = self.size(usingUIFont: font)
            
            if size.width <= targetSize.width && size.height <= targetSize.height {
                high = mid
            } else {
                low = mid + 1
            }
        }
        
        return CGFloat(low)
    }
}