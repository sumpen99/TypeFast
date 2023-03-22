//
//  UIViewExtensions.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-21.
//

import UIKit


extension UIViewController {
    
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
    
   
}
