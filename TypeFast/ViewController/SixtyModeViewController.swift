//
//  SixtyModeViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class SixtyModeViewController : UIViewController,PopUpDelegate,UITextFieldDelegate{
    
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var userPointsLabel: UILabel!
    @IBOutlet weak var wordToTypeLabel: UILabel!
    @IBOutlet weak var startNewGameButton: UIButton!
    @IBOutlet weak var userInputTextview: UITextField!
    
    var gameMode : String = ""
    var counter: Counter?
    override func viewDidLoad() {
        super.viewDidLoad()
        if(counter != nil){ printAny("not nil")}
        configureTopMenu()
        configureTextfield()
        //configureTimeLeftLabel()
        //configureUserPointsLabel()
        //configureWordToTypelabel()
        configureStartNewGameButton()
    }
    
    private func configureTextfield(){
        addKeyboardResponder()
        hideKeyboardWhenTappedAround()
        userInputTextview.delegate = self
    }
    
    /*private func configureWordToTypelabel(){
        /*wordToTypeLabel.fadeOut(completion: {
                (finished: Bool) -> Void in
            self.wordToTypeLabel.fadeIn()
        })*/
        wordToTypeLabel.shrink(completion: currentWordTimeEnded)
    }*/
    
    /*private func configureTimeLeftLabel(){
        timeLeftLabel.text = "60"
    }
    
    private func configureUserPointsLabel(){
        userPointsLabel.text = ""
    }*/
    
    private func configureCounter(){
        counter = Counter(to: 0,from: 60,step: 1){ currentTime in
            self.updateTimeLeftLabel(withValue: Int(currentTime))
        }
        counter?.toggle()
    }
    
    private func configureStartNewGameButton(){
        startNewGameButton.addTarget(self, action: #selector(showCountDownScreen), for: .touchUpInside)
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
    
    private func createMenuButton() -> UIButton{
        let menuButton = UIButton(frame: CGRect(x:0,y:0,width:100,height:30))
        //menuButton.addTarget(self, action: #selector(tapFunction), for: .touchUpInside)
        menuButton.setTitle(gameMode, for: .normal)
        menuButton.backgroundColor = .lightGray
        menuButton.layer.cornerRadius = 10
        return menuButton
    }
    
    private func currentWordTimeEnded(finished: Bool){
        
    }
    
    private func animateWordToType(){
        wordToTypeLabel.fadeOut(){ [weak self] finished in
            //self?.counter?.stop()
        }
        /*wordToTypeLabel.shrink(){ finished in
            
        }*/
    }
    
    
    private func updateTimeLeftLabel(withValue: Int){
        if(withValue % 10 == 0){
            self.userInputTextview.isEnabled = false
            printAny("Times Up")
            return
        }
        timeLeftLabel.text = "\(withValue)"
        printAny("\(withValue)")
    }
    
    func popupIsDismissed(){
        configureCounter()
        animateWordToType()
        userInputTextview.isHidden = false
        userInputTextview.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.text = ""
        return true
    }
    
    @objc
    func showCountDownScreen(){
        startNewGameButton.isHidden = true
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
        counter?.stop()
        counter = nil
        printAny("view is gone")
    }
    
    deinit{
        printAny("deinit viewcontroller")
    }
    
}
