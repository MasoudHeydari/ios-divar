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

//    private struct AssociatedKeys {
//        static var padding = UIEdgeInsets()
//    }
//
//    /// this property add padding to this UILabel
//    public var padding: UIEdgeInsets? {
//        get {
//            return objc_getAssociatedObject(self, &AssociatedKeys.padding) as? UIEdgeInsets
//        }
//        set {
//            if let newValue = newValue {
//                objc_setAssociatedObject(self, &AssociatedKeys.padding, newValue as UIEdgeInsets, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            }
//        }
//    }
//
//    override open func draw(_ rect: CGRect) {
//        if let insets = padding {
//            self.drawText(in: rect.inset(by: insets))
//        } else {
//            self.drawText(in: rect)
//        }
//    }
//
//    override open var intrinsicContentSize: CGSize {
//        guard let text = self.text else { return super.intrinsicContentSize }
//        
//        var contentSize = super.intrinsicContentSize
//        var textWidth: CGFloat = frame.size.width
//        var insetsHeight: CGFloat = 0.0
//        
//        if let insets = padding {
//            textWidth -= insets.left + insets.right
//            insetsHeight += insets.top + insets.bottom
//        }
//        
//        let newSize = text.boundingRect(with: CGSize(width: textWidth, height: CGFloat.greatestFiniteMagnitude),
//                                        options: NSStringDrawingOptions.usesLineFragmentOrigin,
//                                        attributes: [NSAttributedString.Key.font: self.font], context: nil)
//        
//        contentSize.height = ceil(newSize.size.height) + insetsHeight
//        
//        return contentSize
//    }
}

