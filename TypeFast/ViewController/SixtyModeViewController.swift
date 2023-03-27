//
//  SixtyModeViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class SixtyModeViewController : GameModeViewController,CounterPopUpDelegate,EndOfGamePopUpDelegate{
    
    @IBOutlet weak var pulseLabel: UIImageView!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var userPointsLabel: UILabel!
    @IBOutlet weak var wordToTypeLabel: UILabel!
    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var userInputTextview: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        printAny("init sixty")
        configureTopMenu()
        configureTextfield()
        configureApplicationNotifications()
        configureStartNewGameButton(startNewGameButton)
        userInputTextview.delegate = self
    }
    
    private func configureCounter(){
        counter = Counter(to: 0,from: Double(TOTAL_GAME_TIME),step: 1){ currentTime in
            self.updateTimeLeftLabel(withValue: Int(currentTime))
        }
        counter?.toggle()
    }
    
    private func animateWordToType(){
        wordToTypeLabel.text = wordModel.getNextWord()
        wordToTypeLabel.fadeOut(){ [weak self] finished in
            guard let strongSelf = self else { return }
            if(finished){
                strongSelf.evaluateAnswer()
            }
        }
    }
    
    override func evaluateAnswer(){
        resetForNewRound(
            userTypedWord: userInputTextview,
            wordToTypeLabel: wordToTypeLabel,
            userPointslabel: userPointsLabel)
        animateWordToType()
    }
    
    private func updateTimeLeftLabel(withValue: Int){
        if(withValue <= 0){
            stopCurrentGame()
            return
        }
        timeLeftLabel.text = "\(withValue)"
    }
    
    private func stopCurrentGame(){
        timeLeftLabel.clear()
        removeAnimations()
        userInputTextview.unActivate()
        counter?.stop()
        counter = nil
        showEndOfGamePopUp()
    }
    
    func counterPopupIsDismissed(){
        configureCounter()
        updateUserPointsLabel(userPointsLabel)
        userInputTextview.clearAndActivate()
        timeLeftLabel.text = "\(TOTAL_GAME_TIME)"
        startAnimations()
    }
    
    func endOfGamePopupIsDismissed() {
        startNewGameButton.isHidden = false
        APP_PLAYER.resetPlayer()
        updateUserPointsLabel(userPointsLabel)
    }
    
    private func startAnimations(){
        pulseLabel.pulse()
        animateWordToType()
    }
    
    private func removeAnimations(){
        wordToTypeLabel.layer.removeAllAnimations()
        pulseLabel.layer.removeAllAnimations()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        removeAnimations()
        counter?.stop()
        counter = nil
        printAny("sixty mode view is gone")
    }
    
    override func applicationDidBecomeActive(notification: NSNotification){
        guard let counter = counter else{ return }
        if counter.resume(){
            animateWordToType()
        }
    }
    
    override func applicationWentInToBackground(notification: NSNotification) {
        counter?.paus()
    }
    
    deinit{
        printAny("deinit sixty viewcontroller")
    }
    
    override func didReceiveMemoryWarning() {
        printAny("memory warning sixty")
    }
    
}
