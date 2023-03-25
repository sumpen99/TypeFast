//
//  SixtyModeViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class SixtyModeViewController : GameModeViewController,CounterPopUpDelegate,EndOfGamePopUpDelegate,UITextFieldDelegate{
    
    @IBOutlet weak var pulseLabel: UIImageView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var userPointsLabel: UILabel!
    @IBOutlet weak var wordToTypeLabel: UILabel!
    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var userInputTextview: UITextField!
    var counter: Counter?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTopMenu()
        configureTextfield()
        startNewGameButton.addTarget(self, action: #selector(showCountDownPopUp), for: .touchUpInside)
        wordModel = WordModel(level: player.level)
    }
    
    private func configureTextfield(){
        addKeyboardResponder()
        hideKeyboardWhenTappedAround()
        userInputTextview.delegate = self
    }
    
    private func configureCounter(){
        counter = Counter(to: 0,from: Double(TOTAL_GAME_TIME),step: 1){ currentTime in
            self.updateTimeLeftLabel(withValue: Int(currentTime))
        }
        counter?.toggle()
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
                customView:createButton(title: player.level)
            ),
        ]
        
    }
    
    private func animateWordToType(){
        wordToTypeLabel.text = wordModel?.getNextWord()
        wordToTypeLabel.fadeOut(){ [weak self] finished in
            guard let strongSelf = self else { return }
            if(finished){
                strongSelf.evaluateAnswer()
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        evaluateAnswer()
        return true
    }
    
    private func evaluateAnswer(){
        wordToTypeLabel.layer.removeAllAnimations()
        guard let userText = userInputTextview.text, let wordToType = wordToTypeLabel.text  else { return }
        player.evaluateAnswer(userText,wordToType: wordToType)
        updateUserPointsLabel()
        animateWordToType()
        userInputTextview.text = ""
    }
    
    private func updateUserPointsLabel(){
        userPointsLabel.text = player.getCurrentScore()
    }
    
    private func updateTimeLeftLabel(withValue: Int){
        if(withValue % TOTAL_GAME_TIME == 0){
            stopCurrentGame()
            return
        }
        timeLeftLabel.text = "\(withValue)"
    }
    
    private func stopCurrentGame(){
        timeLeftLabel.text = ""
        removeAnimations()
        userInputTextview.unActivate()
        counter?.stop()
        counter = nil
        showEndOfGamePopUp()
    }
    
    func counterPopupIsDismissed(){
        configureCounter()
        updateUserPointsLabel()
        userInputTextview.clearAndActivate()
        timeLeftLabel.text = "\(TOTAL_GAME_TIME)"
        startAnimations()
    }
    
    func endOfGamePopupIsDismissed() {
        startNewGameButton.isHidden = false
        player.resetPlayer()
        updateUserPointsLabel()
    }
    
    private func startAnimations(){
        pulseLabel.pulse()
        animateWordToType()
    }
    
    private func removeAnimations(){
        wordToTypeLabel.layer.removeAllAnimations()
        pulseLabel.layer.removeAllAnimations()
    }
    
    func showEndOfGamePopUp(){
        EndOfGamePopupViewController.showPopup(parentVC: self)
    }
    
    @objc
    func showCountDownPopUp(){
        startNewGameButton.isHidden = true
        wordModel?.loadWords()
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
        removeAnimations()
        counter?.stop()
        counter = nil
        printAny("view is gone")
    }
    
    deinit{
        printAny("deinit viewcontroller")
    }
    
}
