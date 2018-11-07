//
//  UIColor+Helper.swift
//  Test1
//
//  Created by Masoud Heydari on 10/13/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

extension UIColor {
    public class var darkRedLight: UIColor {
        return UIColor(r: 153, g: 49, b: 44)
    }
    
    public class var darkRedDark: UIColor {
        return UIColor(r: 130, g: 35, b: 33)
    }
    
    public class var milkyWhite: UIColor {
        return UIColor(r: 250, g: 250, b: 250)
    }
    
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(r: r, g: g, b: b, a: 1)
    }
    
    convenience public init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    class func UIColorFromRGB(rgb: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    class func hexStringToUIColor (hex: String) -> UIColor {
        var string: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (string.hasPrefix("#")) {
            string.remove(at: string.startIndex)
        }
        
        if ((string.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: string).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    struct Gray {
        static var light0: UIColor {
            return UIColor(r: 250, g: 250, b: 250)
        }
        
        static var light1: UIColor {
            return UIColor(r: 240, g: 240, b: 240)
        }
        
        static var light2: UIColor {
            return UIColor(r: 228, g: 228, b: 228)
        }
        
        static var light3: UIColor {
            return UIColor(r: 215, g: 215, b: 215)
        }
        
        static var light4: UIColor {
            return UIColor(r: 200, g: 200, b: 200)
        }
        
        static var light5: UIColor {
            return UIColor(r: 180, g: 180, b: 180)
        }
        
        static var light6: UIColor {
            return UIColor(r: 150, g: 150, b: 150)
        }
        
        static var light7: UIColor {
            return UIColor(r: 130, g: 130, b: 130)
        }
        
        static var light8: UIColor {
            return UIColor(r: 110, g: 110, b: 110)
        }
        
        static var light9: UIColor {
            return UIColor(r: 90, g: 90, b: 90)
        }
        
        static var light10: UIColor {
            return UIColor(r: 70, g: 70, b: 70)
        }

        
        static var blue: UIColor {
            return UIColor(r: 243, g: 248, b: 252)
        }
        
        static var textGrayLight: UIColor {
            return UIColor(r: 174, g: 174, b: 174)
        }
        
        static var textGrayDark: UIColor {
            return UIColor(r: 116, g: 116, b: 116)
        }
        
        static var dividerBackground: UIColor {
            return UIColor(red: 231/255, green: 234/255, blue: 236/255, alpha: 1)
        }
    }
}

