//
//  EndOfGamePopUpViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

import UIKit

protocol EndOfGamePopUpDelegate {
    func endOfGamePopupIsDismissed()
}

class EndOfGamePopupViewController: UIViewController,UITextFieldDelegate, UITableViewDelegate{
    
    static let identifier = "EndOfGamePopupViewController"
    var delegate: EndOfGamePopUpDelegate?
   
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scoreIsGoodEnoughLabel: UILabel!
    @IBOutlet var dialogBoxView: UIView!
  
    private var gameModel: GameModel? = nil
    private var pointsToMakeBoard:Int32 { return SharedPreference.getMinimumScoreToMakeHighScoreTable(APP_PLAYER.level)}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubmitOptions()
        configureTextfield()
        configureBackButton()
        configureTableView()
        configureResultLabels()
    }
    
    private func configureSubmitOptions(){
        if APP_PLAYER.points >= pointsToMakeBoard{
            nameTextField.text = APP_PLAYER.name
            submitButton.addTarget(self, action: #selector(submitHighScoreResult), for: .touchUpInside)
        }
        else{
            scoreIsGoodEnoughLabel.text = ""
            nameTextField.isHidden = true
            submitButton.isHidden = true
        }
    }
    
    private func configureResultLabels(){
        levelLabel.text = APP_PLAYER.level
        pointsLabel.text = APP_PLAYER.getCurrentScore()
    }
    
    private func configureTableView(){
        gameModel = GameModel()
        gameModel?.setTableView(tableView: self.tableView)
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //printAny("you tapped cell \(indexPath.row)")
    }
    
    private func configureBackButton(){
        backButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
    }
    
    private func configureTextfield(){
        addKeyboardResponder()
        hideKeyboardWhenTappedAround()
        nameTextField.delegate = self
    }
    
    @objc
    private func closePopup(){
        self.dismiss(animated: true)
        releaseDelegate()
        releaseGameModel()
    }
    
    @objc
    private func submitHighScoreResult(){
        if APP_PLAYER.setNewName(nameTextField.text){
            SharedPreference.writeNewPlayerIfScoreMadeBoard(){ success in
                let msg = success ? "Saved to High-Score List" : "Unexpected error occurred "
                showSimpleAlert(withTitle: "", withMessage: msg){ finished in
                    self.closePopup()
                }
            }
        }
        else{
            showSimpleAlert(withTitle: "", withMessage: "Please provid a name")
        }
    }
    
    private func releaseGameModel(){
        gameModel?.reset()
        gameModel = nil
    }
    
    private func releaseDelegate(){
        delegate?.endOfGamePopupIsDismissed()
        delegate = nil
    }
    
    private func configureSelf(){
        //view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .flipHorizontal
    }
    
    deinit{
        printAny("deinit popup end of game")
    }
    
    override func didReceiveMemoryWarning() {
        printAny("memory warning end of game")
    }
    
    @objc
    override func onKeyboardShow(keyboardSize: CGRect){
        updateConstraintValue(id: "textfieldBottomConstraint", value: keyboardSize.height)
    }
    
    override func keyboardWillHide(sender: NSNotification){
        updateConstraintValue(id: "textfieldBottomConstraint", value: 20.0)
    }
    
    static func showPopup(parentVC: UIViewController){
        if let popupViewController = UIStoryboard(name: "Main",bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? EndOfGamePopupViewController {
            popupViewController.configureSelf()
            popupViewController.delegate = parentVC as? EndOfGamePopUpDelegate
            parentVC.present(popupViewController, animated: true)
        }
      }
}
