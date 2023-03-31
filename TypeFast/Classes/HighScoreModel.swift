//
//  HighScoreModel.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-27.
//

import UIKit
class HighScoreModel: NSObject,UITableViewDataSource {
    
    let cellReuseIdentifier = "cell"
    private var currentTable = [HighScorePlayer]()
    private var count: Int{ return currentTable.count}
    private weak var tableView: UITableView? = nil
    
    static let userDefault = UserDefaults.standard
    
    func collectData(level:String){
        guard let table = SharedPreference.getPlayersFromTable(level) else { return }
        
        currentTable = table
    }
    
    func setTableView(tableView:UITableView){
        self.tableView = tableView
        self.tableView?.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HighScoreCell = self.tableView?.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! HighScoreCell
        cell.positionLabel.text = "\(indexPath.row + 1)"
        cell.nameLabel.text = currentTable[indexPath.row].name
        cell.scoreLabel.text = "\(currentTable[indexPath.row].points)"
        return cell
    }
    
    func reset(){
        tableView = nil
    }
}
