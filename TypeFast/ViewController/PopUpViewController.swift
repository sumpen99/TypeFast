//
//  PopUpViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-22.
//

import UIKit

protocol PopUpDelegate {
    func popupIsDismissed()
}

class CounterPopupViewController: UIViewController{
    
    @IBOutlet var dialogBoxView: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    static let identifier = "CounterPopupViewController"
    let COUNT_FROM = 3
    var counter: Counter?
    var delegate: PopUpDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCounter()
        updateTimerLabel(withValue: COUNT_FROM)
        //dialogBoxView.layer.cornerRadius = 6.0
        //dialogBoxView.layer.borderWidth = 1.2
        //dialogBoxView.layer.borderColor = UIColor(named: "dialogBoxGray")?.cgColor
        //let tapGesture = UITapGestureRecognizer(target: self, action: #selector( handleTap(sender:)))
        //dialogBoxView.addGestureRecognizer(tapGesture)
    }
    
    /*@objc
    private func handleTap(sender: UITapGestureRecognizer){
        self.dismiss(animated: true)
        //delegate?.handleAction(action: true)
    }*/
    
    private func configureCounter(){
        counter = Counter(to: 0,from: 3,step: 1){ currentTime in
            self.updateTimerLabel(withValue: Int(currentTime))
        }
        counter?.toggle()
    }
    
    private func updateTimerLabel(withValue: Int){
        if(withValue <= 0){
            return closePopup()
        }
        counterLabel.text = "\(withValue)"
    }
    
    private func closePopup(){
        //printAny("still counting")
        counterLabel.text = "GO"
        counter = nil
        delegate?.popupIsDismissed()
        dismiss(animated: true,completion: nil)
    }
    
    private func configureSelf(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        modalPresentationStyle = .custom
        //modalPresentationStyle = .formSheet
        modalTransitionStyle = .crossDissolve
    }
    
    deinit{
        //printAny("deinit popup")
        counter?.stop()
        counter = nil
    }
    
    static func showPopup(parentVC: UIViewController){
        if let popupViewController = UIStoryboard(
            name: "Main",
            bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? CounterPopupViewController {
            popupViewController.configureSelf()
            popupViewController.delegate = parentVC as? PopUpDelegate
            parentVC.present(popupViewController, animated: true)
        }
      }
}
