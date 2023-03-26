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
   
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet var dialogBoxView: UIView!
    
    private var gameModel: GameModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTextfield()
        configureButtons()
        configureTableView()
        configureResultLabel()
    }
    
    private func configureResultLabel(){
        resultLabel.text = "Score: " + APP_PLAYER.getCurrentScore()
    }
    
    private func configureTableView(){
        gameModel = GameModel()
        gameModel?.setTableView(tableView: self.tableView)
        tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        printAny("you tapped cell \(indexPath.row)")
    }
    
    private func configureButtons(){
        closeButton.addTarget(self, action: #selector(closePopup), for: .touchUpInside)
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
