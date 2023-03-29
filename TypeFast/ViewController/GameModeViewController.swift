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
    var menuLevelButton: UIButton? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextfield()
        configureApplicationNotifications()
        APP_PLAYER.resetPlayer()
    }
    
    
    func configureApplicationNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive), name: UIApplication.willEnterForegroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWentInToBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
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
    
    func resetForNewRound(userTypedWord: UITextField,wordToTypeLabel: UILabel){
        wordToTypeLabel.layer.removeAllAnimations()
        let userTypedWord = getUserWrittenText(userTypedWord)
        let wordToType = getCurrentWordToType(wordToTypeLabel)
        let isCorrectAnswer = GameModel.evaluateLastWord(userTypedWord,wordToType)
        APP_PLAYER.updateScore(isCorrectAnswer)
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
    
    func configureTopMenu(btn:UIBarButtonItem){
        guard let menuLevelButton = createButton() else { return }
        navigationItem.rightBarButtonItems = [
            btn,
            UIBarButtonItem(
                customView: menuLevelButton
            ),
        ]
        
    }
    
    func createButton() -> UIButton? {
        menuLevelButton = UIButton(frame: CGRect(x:0,y:0,width:100,height:30))
        menuLevelButton?.setTitle(APP_PLAYER.level, for: .normal)
        menuLevelButton?.backgroundColor = .lightGray
        menuLevelButton?.layer.cornerRadius = 10
        
        let menuClosure = {(action: UIAction) in
            self.menuLevelButton?.setTitle(action.title, for: .normal)
            APP_PLAYER.level = action.title
        }
        var children = [UIAction]()
        for level in GAME_LEVELS{
            if APP_PLAYER.level == level{
                children.append(UIAction(title: level, state: .on, handler: menuClosure))
            }
            else{
                children.append(UIAction(title: level, state: .off, handler: menuClosure))
            }
        }
        menuLevelButton?.menu = UIMenu(children: children)
        menuLevelButton?.showsMenuAsPrimaryAction = true
        menuLevelButton?.changesSelectionAsPrimaryAction = true
        
        return menuLevelButton
    }
    
    func showEndOfGamePopUp(){
        wordModel.clearWordList()
        EndOfGamePopupViewController.showPopup(parentVC: self)
    }
    
    func counterIsCounting() -> Bool {
        return counter != nil && counter!.isCounting
    }
    
    func releaseCounter(){
        counter?.stop()
        counter = nil
    }
    
    func releaseMenuLevelButton(){
        menuLevelButton?.menu = nil
        menuLevelButton = nil
    }
    
    @objc
    func openHighScoreScreen(){
        if counterIsCounting() { return }
        let controller = storyboard?
            .instantiateViewController(withIdentifier: "HighScorePageController") as? HighScorePageController
        present(controller!,animated: true,completion: nil)
    }
    
    @objc
    func loadWordsAndCountDown(){
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
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        releaseCounter()
        releaseMenuLevelButton()
    }
    
    @objc
    func applicationDidBecomeActive(notification: NSNotification) {
    }
    
    @objc
    func applicationWentInToBackground(notification: NSNotification) {
        
    }
}
