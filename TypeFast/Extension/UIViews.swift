//
//  UIViews.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

import UIKit

extension UILabel{
    func clear(){
        text = ""
    }
}

extension UIViewController {
    
    func createButton(title:String) -> UIButton{
        let menuButton = UIButton(frame: CGRect(x:0,y:0,width:100,height:30))
        //menuButton.addTarget(self, action: #selector(tapFunction), for: .touchUpInside)
        menuButton.setTitle(title, for: .normal)
        menuButton.backgroundColor = .lightGray
        menuButton.layer.cornerRadius = 10
        return menuButton
    }
    
    func addKeyboardResponder(){
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(sender:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(sender:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
    }
    
    @objc
    func keyboardWillShow(sender: NSNotification){
        guard let keyboardSize = (sender.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        onKeyboardShow(keyboardSize: keyboardSize)
    }
    
    @objc
    func onKeyboardShow(keyboardSize: CGRect){
        
    }
    
    @objc
    func keyboardWillHide(sender: NSNotification){
        
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func updateConstraintValue(id: String,value: CGFloat){
        for constraint in view.constraints{
            if id == constraint.identifier{
                constraint.constant = value
            }
        }
        
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
   
}

extension UIView{
    
    func loadFromNib(nibName: String) -> UIView?{
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: nibName,bundle: bundle)
        return nib.instantiate(withOwner: self,options: nil).first as? UIView
    }
    
    func fixInView(_ container: UIView!) -> Void{
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func updateConstraintValue(id: String,value: CGFloat){
        for constraint in constraints{
            //printAny(constraint.identifier)
            if id == constraint.identifier{
                constraint.constant = value
            }
        }
    }
    
    func fadeIn(
        duration: TimeInterval = TOTAL_ANSWER_TIME,
        delay: TimeInterval = 0.0,
        _ completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
            
        layer.removeAllAnimations()
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
        duration: TimeInterval = TOTAL_ANSWER_TIME,
        delay: TimeInterval = 0.0,
        _ completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
            
        isHidden = false
        alpha = 1.0
        layer.removeAllAnimations()
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
        duration: TimeInterval = TOTAL_ANSWER_TIME,
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
    
    func pulse(){
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1.0, 1.2, 1.0]
        animation.keyTimes = [0, 0.5, 1]
        animation.duration = 1.0
        animation.repeatCount = Float.infinity
        layer.add(animation, forKey: nil)

    }

}

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
    
    func clear(){
        text = ""
    }
}
