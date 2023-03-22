//
//  UIView.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-21.
//

import UIKit

extension UIView{
    
    func updateConstraintValue(id: String,value: CGFloat){
        for constraint in constraints{
            if id == constraint.identifier{
                print("\(constraint.identifier)")
                constraint.constant = value
            }
        }
        layoutIfNeeded()
    }
}
