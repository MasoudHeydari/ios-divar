//
//  UILabel+Helper.swift
//  Test1
//
//  Created by Masoud Heydari on 10/16/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

extension UILabel {
    func addSpaceBetweenLines(string: String, spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: string)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .right
        paragraphStyle.lineSpacing = spacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        self.attributedText = attributedString
    }
}

