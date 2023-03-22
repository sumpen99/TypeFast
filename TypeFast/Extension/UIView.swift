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
            //printAny(constraint.identifier)
            if id == constraint.identifier{
                constraint.constant = value
            }
        }
    }
}
