//
//  MoveableTextField.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-21.
//

import UIKit

class MoveableTextField: UITextField{
    var originY: CGFloat = 0.0
    var originHeight: CGFloat = 0.0
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        common()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField){
        print("\(frame.origin.y)")
    }
    
    func common(){
        originY = frame.origin.y
        originHeight = frame.height
        addTarget(self, action: #selector(textFieldDidChange(_:)),for: .editingChanged)
        
    }
    
    func moveTo(newPosition: CGFloat){
        frame.origin.y = newPosition - frame.height - 10
    }
    
    func resetOriginY(){
        frame.origin.y = originY
    }
    
   
}
