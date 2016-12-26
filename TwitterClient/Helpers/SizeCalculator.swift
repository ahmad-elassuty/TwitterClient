//
//  SizeCalculator.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import TTTAttributedLabel

/**
 SizeCalculator provides  
 */
struct SizeCalculator {
    
    private init() {}
    
    /**
     Calculates the height that fits the given text.
     
     - Parameters:
        - text:
            The text to calculate its height.
        - maxWidth:
            Maximum allowed width.
        - font:
            The text font.
    */
    static func heightThatFits(text:String, maxWidth: CGFloat, font: UIFont) -> CGFloat {
        let constrainedSize = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let style = NSMutableParagraphStyle()
        style.lineBreakMode = .byWordWrapping
        let textAttributes: [String:AnyObject]? = [NSFontAttributeName: font, NSParagraphStyleAttributeName: style]
        let string = NSMutableAttributedString(string: text, attributes: textAttributes)
        let result = TTTAttributedLabel.sizeThatFitsAttributedString(string, withConstraints: constrainedSize, limitedToNumberOfLines: 0)
        return result.height
    }
    
}
