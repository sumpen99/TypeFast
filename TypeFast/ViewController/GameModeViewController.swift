//
//  GameModeViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

import UIKit

class GameModeViewController: UIViewController,UITextFieldDelegate{
    let wordModel = WordModel()
    var counter: Counter?
    
    func configureApplicationNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWentInToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
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
        let isCorrectAnswer = GameModel.evaluateLastWord(userTypedWord,wordToType)
        APP_PLAYER.updateScore(isCorrectAnswer)
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
                action: #selector(openHighScoreScreen)
            ),
            UIBarButtonItem(
                customView:createButton(title: APP_PLAYER.level)
            ),
        ]
        
    }
    
    func showEndOfGamePopUp(){
        wordModel.clearWordList()
        EndOfGamePopupViewController.showPopup(parentVC: self)
    }
    
    func counterIsCounting() -> Bool {
        return counter != nil && counter!.isCounting
    }
 
    @objc
    func applicationDidBecomeActive(notification: NSNotification) {
    }
    
    @objc
    func applicationWentInToBackground(notification: NSNotification) {
        
    }
    
    override func didReceiveMemoryWarning() {
        printAny("memory warning gamemode")
    }
    
    deinit{
        printAny("deinit gamemode viewcontroller ")
    }
    
    @objc
    func openHighScoreScreen(){
        if counterIsCounting() { return }
        let controller = storyboard?
            .instantiateViewController(withIdentifier: "HighScorePageController") as? HighScorePageController
        present(controller!,animated: true,completion: nil)
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
