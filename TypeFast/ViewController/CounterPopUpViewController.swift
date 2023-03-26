//
//  CounterPopUpViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

import UIKit

protocol CounterPopUpDelegate {
    func counterPopupIsDismissed()
}

class CounterPopupViewController: UIViewController{
    
    @IBOutlet var dialogBoxView: UIView!
    @IBOutlet weak var counterLabel: UILabel!
    static let identifier = "CounterPopupViewController"
    let COUNT_FROM = 3
    var counter: Counter?
    var delegate: CounterPopUpDelegate?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCounter()
        updateTimerLabel(withValue: COUNT_FROM)
    }
    
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
        counterLabel.text = "GO"
        counter = nil
        delegate?.counterPopupIsDismissed()
        delegate = nil
        dismiss(animated: true,completion: nil)
    }
    
    private func configureSelf(){
        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        modalPresentationStyle = .custom
        //modalPresentationStyle = .formSheet
        modalTransitionStyle = .crossDissolve
    }
    
    deinit{
        printAny("deinit popup counter")
        counter?.stop()
        counter = nil
    }
    
    override func didReceiveMemoryWarning() {
        printAny("memory warning counter")
    }
    
    static func showPopup(parentVC: UIViewController){
        if let popupViewController = UIStoryboard(name: "Main",bundle: nil)
            .instantiateViewController(withIdentifier: identifier) as? CounterPopupViewController {
            popupViewController.configureSelf()
            popupViewController.delegate = parentVC as? CounterPopUpDelegate
            parentVC.present(popupViewController, animated: true)
        }
      }
}
