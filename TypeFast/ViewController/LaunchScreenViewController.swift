//
//  LaunchScreenViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-20.
//

import UIKit

class LaunchScreenViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource{
    @IBOutlet weak var gameModePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePickerView()
        test()
    }
    
    func test(){
        //guard let players = HighScoreModel.getPlayersFromTable("Medium") else{ return }
        //HighScoreModel.removePlayersFromTable("Easy")
        //["Easy","Medium","Hard","Expert"]
        let level = "Expert"
        /*HighScoreModel.removePlayersFromTable(level)
        
        let player1 = HighScorePlayer(name: "Fredrik1", date: getCurrentDate(), points: 10)
        let player2 = HighScorePlayer(name: "Fredrik2", date: getCurrentDate(), points: 11)
        let player3 = HighScorePlayer(name: "Fredrik3", date: getCurrentDate(), points: 12)
        let player4 = HighScorePlayer(name: "Fredrik4", date: getCurrentDate(), points: 9)
        let player5 = HighScorePlayer(name: "Fredrik5", date: getCurrentDate(), points: 20)
        let player6 = HighScorePlayer(name: "Fredrik6", date: getCurrentDate(), points: 0)
        let player7 = HighScorePlayer(name: "Fredrik7", date: getCurrentDate(), points: 0)
        let player8 = HighScorePlayer(name: "Fredrik8", date: getCurrentDate(), points: 15)
        let player9 = HighScorePlayer(name: "Fredrik9", date: getCurrentDate(), points: 1)
        let player10 = HighScorePlayer(name: "Fredrik10", date: getCurrentDate(), points: 3)
        HighScoreModel.writeNewPlayerToTable(level, player: player1)
        HighScoreModel.writeNewPlayerToTable(level, player: player2)
        HighScoreModel.writeNewPlayerToTable(level, player: player3)
        HighScoreModel.writeNewPlayerToTable(level, player: player4)
        HighScoreModel.writeNewPlayerToTable(level, player: player5)
        HighScoreModel.writeNewPlayerToTable(level, player: player6)
        HighScoreModel.writeNewPlayerToTable(level, player: player7)
        HighScoreModel.writeNewPlayerToTable(level, player: player8)
        HighScoreModel.writeNewPlayerToTable(level, player: player9)
        HighScoreModel.writeNewPlayerToTable(level, player: player10)*/
        
        guard let players = HighScoreModel.getPlayersFromTable(level) else{ return }
        for player in players {
            printAny(player.points)
        }
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
        return GAME_LEVELS.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GAME_LEVELS[row]
    }
    
    override func didReceiveMemoryWarning() {
        printAny("memory warning launchscreren")
    }
    
}
