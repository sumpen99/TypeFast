//
//  SixtyModeViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class SixtyModeViewController : UIViewController,PopUpDelegate{
    
    @IBOutlet weak var wordToTypeLabel: UILabel!
    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var userInputTextview: MoveableTextField!
    
    var gameMode : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardResponder()
        hideKeyboardWhenTappedAround()
        configureTopMenu()
        configureStartNewGameButton()
        configureWordToTypelabel()
    }
    
    private func configureWordToTypelabel(){
        wordToTypeLabel.text = ""
    }
    
    private func configureStartNewGameButton(){
        
    }
    
    private func configureTopMenu(){
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                title: "HighScore",
                style: .done,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                customView:createMenuButton()
            ),
        ]
        
    }
    
    func createMenuButton() -> UIButton{
        let menuButton = UIButton(frame: CGRect(x:0,y:0,width:100,height:50))
        menuButton.addTarget(self, action: #selector(tapFunction), for: .touchUpInside)
        menuButton.setTitle(gameMode, for: .normal)
        menuButton.backgroundColor = .lightGray
        menuButton.layer.cornerRadius = 10
        return menuButton
    }
    
    func handleAction(action: Bool){
        printAny("hepp")
    }
    
    @objc
    func tapFunction(){
        CounterPopupViewController.showPopup(parentVC: self)
    }
    
    @objc
    override func onKeyboardShow(keyboardSize: CGRect){
        updateConstraintValue(id: "bottomConstraintForUserInput", value: -keyboardSize.height)
    }
    
    override func keyboardWillHide(sender: NSNotification){
        updateConstraintValue(id: "bottomConstraintForUserInput", value: -10.0)
    }
    
}
