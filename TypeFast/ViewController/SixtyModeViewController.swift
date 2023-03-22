//
//  SixtyModeViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class SixtyModeViewController : UIViewController{
    
    @IBOutlet weak var userInputTextview: MoveableTextField!
    var gameMode : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardResponder()
        hideKeyboardWhenTappedAround()
        configureTopMenu()
    }
    
    private func configureTopMenu(){
        let customLabel = UIButton(frame: CGRect(x:0,y:0,width:100,height:50))
        customLabel.addTarget(self, action: #selector(tapFunction), for: .touchUpInside)
        customLabel.setTitle(gameMode, for: .normal)
        customLabel.backgroundColor = .lightGray 
        customLabel.layer.cornerRadius = 10
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                title: "HighScore",
                style: .done,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                customView:customLabel
            ),
        ]
        
    }
    
    @objc
    func tapFunction(){
        print("tap callback function")
        
    }
    
    @objc
    override func onKeyboardShow(keyboardSize: CGRect){
        userInputTextview.moveTo(newPosition: APP_SCREEN_DIMENSIONS.height - keyboardSize.height)
    }
    
    override func keyboardWillHide(sender: NSNotification){
        userInputTextview.resetOriginY()
    }
    
}
