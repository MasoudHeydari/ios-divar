//
//  UIDevice+Helper.swift
//  Test1
//
//  Created by Masoud Heydari on 11/12/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import UIKit

extension UIDevice {
    enum kind {
        case iPad
        case iPhone
    }
    
    static func getKind() -> kind {
        if UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone {
            return kind.iPhone
        } else {
            return kind.iPad
        }
    }
}
