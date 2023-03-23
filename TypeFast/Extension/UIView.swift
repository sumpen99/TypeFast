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
    
    func fadeIn(
        duration: TimeInterval = 5.0,
        delay: TimeInterval = 0.0,
        _ completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
            
        
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: {
                self.alpha = 1.0
            },
            completion: completion)
        
    }

    func fadeOut(
        duration: TimeInterval = 5.0,
        delay: TimeInterval = 0.0,
        _ completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
            
        isHidden = false
        alpha = 1.0
            
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: UIView.AnimationOptions.curveEaseIn,
            animations: {
                self.alpha = 0.0
            },
            completion: completion)
    }
    
    func shrink(
        duration: TimeInterval = 5.0,
        delay: TimeInterval = 0.0,
        completion: @escaping (Bool) -> Void){
        
        isHidden = false
        transform = CGAffineTransformMakeScale(1, 1)
        layer.removeAllAnimations()
        UIView.animate(
            withDuration: 5.0,
            animations: { [weak self] () -> Void in
                self?.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            },
            completion: completion
        )
    }

}
