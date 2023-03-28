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

extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}

extension  UIViewController {

    func showSimpleAlert(withTitle title: String,
                         withMessage message:String,
                         completion: ((_ result:Bool) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
            completion?(true)
        })
        alert.addAction(ok)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
    
    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}

extension HighScorePageController: UIPageViewControllerDataSource {
 
    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(where: {$0 === viewController}) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
     
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }
        
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(where: {$0 === viewController})
        else {
            return nil
        }
        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count
        
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }
        
        guard orderedViewControllersCount > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
       
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return orderedViewControllers.count
    }

    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        guard let firstViewController = viewControllers?.first,
              let firstViewControllerIndex = orderedViewControllers.firstIndex(where: {$0 === firstViewController}) else {
                return 0
        }
        
        return firstViewControllerIndex
    }
    
}

extension UIColor {

    var lighterColor: UIColor {
        return lighterColor(removeSaturation: 0.5, resultAlpha: -1)
    }

    func lighterColor(removeSaturation val: CGFloat, resultAlpha alpha: CGFloat) -> UIColor {
        var h: CGFloat = 0, s: CGFloat = 0
        var b: CGFloat = 0, a: CGFloat = 0

        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a)
            else {return self}

        return UIColor(hue: h,
                       saturation: max(s - val, 0.0),
                       brightness: b,
                       alpha: alpha == -1 ? a : alpha)
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
