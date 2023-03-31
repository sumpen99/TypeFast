//
//  GameModel.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-26.
//
import UIKit

class GameModel: NSObject,UITableViewDataSource{
    let cellReuseIdentifier = "cell"
    private static var wordsInLastSession = [(userTypedWord:String,correctAnswer:String)]()
    private var count: Int{ return GameModel.wordsInLastSession.count}
    private weak var tableView: UITableView? = nil
    
    func setTableView(tableView:UITableView){
        self.tableView = tableView
        self.tableView?.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: WordCell = self.tableView?.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! WordCell
        let cellValues = getNextCellValues(index: indexPath.row)
        cell.correctWordLabel.text = cellValues.0
        cell.userWordLabel.text = cellValues.1
        cell.wordImageView.image = cellValues.2
        cell.wordImageView.tintColor = cellValues.3
        
        return cell
    }
    
    func getNextCellValues(index: Int) -> (String,String,UIImage,UIColor){
        var img: UIImage
        var color: UIColor
        let userTypedWord = GameModel.wordsInLastSession[index].userTypedWord
        let correctAnswer = GameModel.wordsInLastSession[index].correctAnswer
        let isCorrect = userTypedWord == correctAnswer
        if isCorrect{
            img = UIImage(systemName: "checkmark") ?? UIImage()
            color = .green.lighterColor
        }
        else{
            img = UIImage(systemName: "xmark") ?? UIImage()
            color = .red.lighterColor
        }
        return (correctAnswer,userTypedWord,img,color)
    }
    
    static func evaluateLastWord(_ userTypedWord: String,_ wordToType: String) -> Bool{
        wordsInLastSession.append((userTypedWord:userTypedWord,correctAnswer:wordToType))
        return userTypedWord == wordToType
    }
    
    static func clearSelf(){
        GameModel.wordsInLastSession.removeAll()
    }
    
    func reset(){
        GameModel.wordsInLastSession.removeAll()
        tableView = nil
    }
    
}
