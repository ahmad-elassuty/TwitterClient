//
//  SizeCalculator.swift
//  TwitterClient
//
//  Created by Ahmed Elassuty on 12/24/16.
//  Copyright © 2016 Eventtus. All rights reserved.
//

import TTTAttributedLabel

struct SizeCalculator {
    
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
