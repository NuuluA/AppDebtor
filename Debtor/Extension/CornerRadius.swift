//
//  CornerRadius.swift
//  Debtor
//
//  Created by Арген on 12.02.2022.
//

import UIKit

extension UIView {
    @IBInspectable var cornerRadius : CGFloat {
        get {
            return self.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
