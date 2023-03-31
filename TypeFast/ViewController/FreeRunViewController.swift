//
//  FreeRunViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class FreeRunViewController: GameModeViewController,CounterPopUpDelegate{
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var progressView: CircularProgressView!
    @IBOutlet weak var wordToTypeLabel: UILabel!
    @IBOutlet weak var procentLabel: UILabel!
    @IBOutlet weak var userInputTextView: UITextField!
    
    var sliderLabel: UILabel? = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTopMenu(btn:UIBarButtonItem(
            title: "Options",
            style: .done,
            target: self,
            action: #selector(showOptionsMenu)
        ))
        configureButtons()
        userInputTextView.delegate = self
        getUserResponseTime()
    }
    
    private func getUserResponseTime(){
        let value = SharedPreference.getDoubleValue(key: USER_RESPONSE_TIME)
        APP_PLAYER.preferredAnswerTime = max(5.0,value)
    }
    
    private func configureButtons(){
        startButton.addTarget(self, action: #selector(showCountDownPopUp), for: .touchUpInside)
        stopButton.addTarget(self, action: #selector(pausGame), for: .touchUpInside)
        switchButton(stateRun: false)
    }
    
    @objc
    func sliderValueDidChange(_ slider:UISlider){
        sliderLabel?.text = String(format: "%.1f", slider.value)
    }
    
    @objc
    func showOptionsMenu(_ sender: AnyObject) {
        if counterIsCounting() { return }
        let sliderAlert = UIAlertController(
            title: "Set Preferred Answer Time",
            message: "\n\n\n\n\n\n\n",
            preferredStyle: .alert)

        
        sliderLabel = UILabel(frame:CGRect(x: 120, y: 80, width: 100, height: 60))
        
        let slider = UISlider(frame:CGRect(x: 10, y: 100, width: 250, height: 80))
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
            
        var startValue = APP_PLAYER.preferredAnswerTime
        startValue = startValue < 5.0 ? 5.0 : startValue
        slider.minimumValue = 5.0
        slider.maximumValue = 25.0
        slider.value = Float(startValue)
        slider.isContinuous = true
        slider.tintColor = UIColor.red
        sliderAlert.view.addSubview(sliderLabel ?? UILabel())
        sliderAlert.view.addSubview(slider)
        sliderLabel?.text = String(format: "%.1f", startValue)
        
        let sliderAction = UIAlertAction(title: "OK", style: .default, handler: { (result : UIAlertAction) -> Void in
            APP_PLAYER.preferredAnswerTime = Double(slider.value)
            SharedPreference.writeData(key: USER_RESPONSE_TIME, value: APP_PLAYER.preferredAnswerTime)
         })

        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)

        sliderAlert.addAction(sliderAction)
        sliderAlert.addAction(cancelAction)

        //present the sliderAlert message
        self.present(sliderAlert, animated: true, completion: nil)
    }
    
    @objc
    func pausGame(_ btn: UIBarButtonItem){
        if counterIsCounting(){
            stopButton.setTitle("Resume", for: .normal)
            counter?.paus()
            removeAnimations(wordToTypeLabel: wordToTypeLabel)
            startButton.isEnabled = true
            menuLevelButton?.isEnabled = true
        }
        else{
            counter?.resume()
            stopButton.setTitle("Stop  ", for: .normal)
            animateWordToType()
            startButton.isEnabled = false
            userInputTextView.clearAndActivate()
        }
    }
    
    @objc
    func showCountDownPopUp(_ btn: UIBarButtonItem){
        stopCurrentGame()
        loadWordsAndCountDown()
    }
    
    private func configureCounter(){
        counter = Counter(to: 0,
                          from: Double(INFINITE_GAME_TIME),
                          step: 1){ [weak self] currentTime in
            guard let strongSelf = self else { return }
            strongSelf.updateTimeLeftLabel(withValue: Int(currentTime))
        }
        counter?.toggle()
    }
    
    private func updateTimeLeftLabel(withValue: Int){
        if(withValue <= 0){
            stopCurrentGame()
            return
        }
        timerLabel.text = "\(withValue)"
    }
    
    private func stopCurrentGame(){
        APP_PLAYER.resetPlayer()
        resetStopButton()
        timerLabel.clear()
        removeAnimations(wordToTypeLabel: wordToTypeLabel,pulseLabel: nil)
        userInputTextView.unActivate()
        counter?.stop()
        counter = nil
        switchButton(stateRun: false)
        menuLevelButton?.isEnabled = true
    }
    
    override func animateWordToType(){
        wordToTypeLabel.text = wordModel.getNextWord()
        wordToTypeLabel.fadeOut(duration:APP_PLAYER.preferredAnswerTime){ [weak self] finished in
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
        procentLabel.text = APP_PLAYER.getCurrentDoubleScore()
        animateWordToType()
    }
    
    func counterPopupIsDismissed(){
        configureCounter()
        userInputTextView.clearAndActivate()
        animateWordToType()
        menuLevelButton?.isEnabled = false
        timerLabel.text = "\(INFINITE_GAME_TIME)"
        progressView.isHidden = false
        switchButton(stateRun: true)
        resetProgressLabels()
    }
    
    private func resetProgressLabels(){
        progressView.percent = APP_PLAYER.getCurrentScore()
        procentLabel.text = ""
    }
    
    private func switchButton(stateRun:Bool){
        startButton.isEnabled = !stateRun
        stopButton.isEnabled = stateRun
    }
    
    private func resetStopButton(){
        stopButton.setTitle("Stop  ", for: .normal)
        stopButton.isEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        sliderLabel = nil
        removeAnimations(wordToTypeLabel: wordToTypeLabel,pulseLabel: nil)
        APP_PLAYER.resetPlayer()
        
    }
    
}
