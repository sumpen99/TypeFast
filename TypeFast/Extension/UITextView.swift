//
//  UITextView.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

import UIKit

extension UITextField{
    
    func clearAndActivate(){
        text = ""
        isHidden = false
        isEnabled = true
        becomeFirstResponder()
    }
    
    func unActivate(){
        isEnabled = false
        isHidden = true
    }
}
