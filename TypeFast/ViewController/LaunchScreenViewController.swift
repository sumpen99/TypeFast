//
//  LaunchScreenViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class LaunchScreenViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    
    @IBOutlet weak var gameModePickerView: UIPickerView!
    var pickerData: [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is SixtyModeViewController {
            let vc = segue.destination as? SixtyModeViewController
            
            guard let value = pickerView(
                gameModePickerView,
                titleForRow: gameModePickerView.selectedRow(inComponent: 0),
                forComponent: 0)
            else { vc?.gameMode = "Easy"; return; }
            
            vc?.gameMode = value
        }
    }
    
    private func configurePickerView(){
        gameModePickerView.delegate = self
        gameModePickerView.dataSource = self
        pickerData = ["Easy","Medium","Hard","Professional"]
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    
    /*@objc
    func moveToSixtySecondsViewController(){
        let controller = storyboard?
            .instantiateViewController(withIdentifier: "GameModeSixty") as? SixtyModeViewController
        present(controller!,animated: false,completion: nil)
    }*/
    
    /*func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    }*/
    
}
