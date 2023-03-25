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

class EndOfGamePopupViewController: UIViewController,UITextFieldDelegate{
    static let identifier = "EndOfGamePopupViewController"
    var delegate: EndOfGamePopUpDelegate?
   
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet var dialogBoxView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        //textfieldBottomConstraint
        dialogBoxView.layer.cornerRadius = 6.0
        dialogBoxView.layer.borderWidth = 1.2
        dialogBoxView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector( handleTap(sender:)))
        //dialogBoxView.addGestureRecognizer(tapGesture)
        configureTextfield()
        configureButtons()
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
        delegate?.endOfGamePopupIsDismissed()
    }
    
    private func configureSelf(){
        //view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        modalPresentationStyle = .fullScreen
        modalTransitionStyle = .flipHorizontal
    }
    
    deinit{
        printAny("deinit popup end of game")
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
