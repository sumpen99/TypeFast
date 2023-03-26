//
//  GameModeViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

import UIKit

class GameModeViewController: UIViewController,UITextFieldDelegate{
    
    let wordModel = WordModel()
    let gameModel = GameModel()
    
    func configureStartNewGameButton(_ btn: UIButton){
        btn.addTarget(self, action: #selector(showCountDownPopUp(_:)), for: .touchUpInside)
    }
    
    func configureTextfield(){
        addKeyboardResponder()
        hideKeyboardWhenTappedAround()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        evaluateAnswer()
        return true
    }
    
    func evaluateAnswer(){ }
    
    func resetForNewRound(userTypedWord: UITextField,wordToTypeLabel: UILabel,userPointslabel: UILabel){
        wordToTypeLabel.layer.removeAllAnimations()
        let userTypedWord = getUserWrittenText(userTypedWord)
        let wordToType = getCurrentWordToType(wordToTypeLabel)
        APP_PLAYER.updateScore(gameModel.evaluateAnswer(userTypedWord,wordToType))
        userPointslabel.text = APP_PLAYER.getCurrentScore()
    }
    
    func updateUserPointsLabel(_ userPointslabel: UILabel){
        userPointslabel.text = APP_PLAYER.getCurrentScore()
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
                customView:createButton(title: APP_PLAYER.level)
            ),
        ]
        
    }
    
    func showEndOfGamePopUp(){
        wordModel.clearWordList()
        EndOfGamePopupViewController.gameModel = gameModel
        EndOfGamePopupViewController.showPopup(parentVC: self)
    }
    
    override func didReceiveMemoryWarning() {
        printAny("memory warning gamemode")
    }
    
    deinit{
        gameModel.reset()
        printAny("deinit gamemode viewcontroller ")
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
