//
//  UILabel+Height.swift
//  TheMovieDBClient
//
//  Created by Rigoberto Saenz Imbacuan on 8/1/19.
//  Copyright © 2019 Rigoberto Saenz Imbacuan. All rights reserved.
//

import UIKit

extension UILabel {
    
    func calculateHeight() -> CGFloat {
        
        let labelWidth = self.frame.width
        
        guard let labelText = self.text,
              let labelFont = self.font,
              labelWidth > 0 else {
            return 0
        }
        
        let rectHeight = getRectangleHeight(text: labelText, width: labelWidth, font: labelFont)
        let labelHeight = ceil(rectHeight)
        return labelHeight
    }
    
    private func getRectangleHeight(text: String, width: CGFloat, font: UIFont) -> CGFloat {
        
        let rectInitSize = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rectOptions = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let rectAttributes = [NSAttributedString.Key.font: font]
        let rectHeight = text.boundingRect(with: rectInitSize, options: rectOptions, attributes: rectAttributes, context: nil).height
        
        return rectHeight
    }
}
