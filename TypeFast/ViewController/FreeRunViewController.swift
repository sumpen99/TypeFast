//
//  FreeRunViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class FreeRunViewController: GameModeViewController,CounterPopUpDelegate{
    
    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var wordToTypeLabel: UILabel!
    @IBOutlet weak var procentLabel: UILabel!
    @IBOutlet weak var userInputTextView: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTopMenu(btn:UIBarButtonItem(
            title: "Start Game",
            style: .done,
            target: self,
            action: #selector(loadWordsAndCountDown)
        ))
        userInputTextView.delegate = self
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
            userTypedWord: userInputTextView,
            wordToTypeLabel: wordToTypeLabel)
        progressView.percent = APP_PLAYER.getCurrentScore()
        procentLabel.text = APP_PLAYER.getCurrentScore()
        animateWordToType()
    }
    
    func counterPopupIsDismissed(){
        userInputTextView.clearAndActivate()
        progressView.percent = 0.0
        animateWordToType()
        //timeLeftLabel.text = "\(TOTAL_GAME_TIME)"
        //startAnimations()
    }
    
    override func applicationDidBecomeActive(notification: NSNotification){
        
    }
    
    override func applicationWentInToBackground(notification: NSNotification) {
    }
    
    deinit{
        printAny("deinit free run viewcontroller")
    }
    
    
}
