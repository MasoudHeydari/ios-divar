//
//  String+Helper.swift
//  Test1
//
//  Created by Masoud Heydari on 11/24/18.
//  Copyright © 2018 Masoud Heydari. All rights reserved.
//

import Foundation

extension String {
    
    // added by: Masoud Heydari   24 NOV 2018   09:04 AM
    var isValidEmail: Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
    
}

