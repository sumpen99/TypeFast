//
//  LaunchScreenViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class LaunchScreenViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    var pickerData = ["Easy","Medium","Hard","Expert"]
    @IBOutlet weak var gameModePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
    }
    
    private func configurePickerView(){
        gameModePickerView.dataSource = self
        gameModePickerView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.destination is GameModeViewController {
            setSelectedValue()
        }
    }
    
    func setSelectedValue(){
        guard let value = pickerView(
                gameModePickerView,
                titleForRow: gameModePickerView.selectedRow(inComponent: 0),
                forComponent: 0)
        else {
            APP_PLAYER.level = "Easy"
            return
        }
        APP_PLAYER.level = value
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
    
    override func didReceiveMemoryWarning() {
        printAny("memory warning launchscreren")
    }
    
}
