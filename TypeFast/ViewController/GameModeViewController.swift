//
//  GameModeViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

import UIKit

protocol GameModeDelegate {
    func evaluateAnswer()
}

class GameModeViewController: UIViewController,UITextFieldDelegate{
    var gameModeDelegate: GameModeDelegate?
    
    func configureStartNewGameButton(_ btn: UIButton){
        btn.addTarget(self, action: #selector(showCountDownPopUp(_:)), for: .touchUpInside)
    }
    
    func configureTextfield(){
        addKeyboardResponder()
        hideKeyboardWhenTappedAround()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        gameModeDelegate?.evaluateAnswer()
        return true
    }
    
    func resetForNewRound(userTypedWord: UITextField,wordToTypeLabel: UILabel,userPointslabel: UILabel){
        wordToTypeLabel.layer.removeAllAnimations()
        player.updateScore(gameModel.evaluateAnswer(
                                     getUserWrittenText(userTypedWord),
                                     getCurrentWordToType(wordToTypeLabel)))
        userPointslabel.text = player.getCurrentScore()
    }
    
    func updateUserPointsLabel(_ userPointslabel: UILabel){
        userPointslabel.text = player.getCurrentScore()
    }
    
    
    func getCurrentWordToType(_ label: UILabel) -> String{
        let word = label.text ?? "Undefined Random Word"
        label.clear()
        return word
    }
    
    func getUserWrittenText(_ userTextField: UITextField) -> String{
        let word = userTextField.text ?? "Undefined User Word"
        userTextField.clear()
        return word
    }
    
    func configureTopMenu(){
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(
                title: "HighScore",
                style: .done,
                target: self,
                action: nil
            ),
            UIBarButtonItem(
                customView:createButton(title: player.level)
            ),
        ]
        
    }
    
    func showEndOfGamePopUp(){
        wordModel.clearWordList()
        EndOfGamePopupViewController.showPopup(parentVC: self)
    }
    
    @objc
    func showCountDownPopUp(_ btn: UIButton){
        btn.isHidden = true
        wordModel.loadWords()
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
