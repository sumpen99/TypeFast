//
//  HighScoreViewController.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-26.
//

import UIKit

class HighScoreViewController: UIViewController{
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var highScoreModel: HighScoreModel?
    var level: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        closeButton.addTarget(self, action: #selector(close) , for: .touchUpInside)
        configureTitleLabel()
        configureTableView()
    }
    
    @objc
    func close(){
        self.dismiss(animated: true)
    }
    
    func configureTitleLabel(){
        levelLabel.text = level
    }
    
    private func configureTableView(){
        highScoreModel = HighScoreModel()
        highScoreModel?.collectData(level: self.level)
        highScoreModel?.setTableView(tableView: self.tableView)
        //gameModel = GameModel()
        //gameModel?.setTableView(tableView: self.tableView)
        //tableView.delegate = self
    }
    
}
