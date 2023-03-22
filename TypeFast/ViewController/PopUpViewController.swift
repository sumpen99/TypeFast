//
//  PopUpViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-22.
//

import UIKit
protocol PopUpDelegate {
    func handleAction(action: Bool)
}

class CounterPopupViewController: UIViewController {
    
    @IBOutlet var dialogBoxView: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    static let identifier = "CounterPopupViewController"
    var delegate: PopUpDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        //dialogBoxView.layer.cornerRadius = 6.0
        //dialogBoxView.layer.borderWidth = 1.2
        //dialogBoxView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector( handleTap(sender:)))
        dialogBoxView.addGestureRecognizer(tapGesture)
        //configureLabel()
    }
    
    @objc
    func handleTap(sender: UITapGestureRecognizer){
        self.dismiss(animated: true)
        delegate?.handleAction(action: true)
    }
    
    static func showPopup(parentVC: UIViewController){
        if let popupViewController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? CounterPopupViewController {
            popupViewController.modalPresentationStyle = .custom
            //popupViewController.modalPresentationStyle = .formSheet
            popupViewController.modalTransitionStyle = .crossDissolve
            popupViewController.delegate = parentVC as? PopUpDelegate
            parentVC.present(popupViewController, animated: true)
        }
      }
}
