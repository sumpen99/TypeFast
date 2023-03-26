//
//  GameModel.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-26.
//
import UIKit

class GameModel: NSObject,UITableViewDataSource{
    let cellReuseIdentifier = "cell"
    private var correctWords = [String]()
    private var userTypedWords = [String]()
    private var count: Int{ return correctWords.count}
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
        let isCorrect = correctWords[index] == userTypedWords[index]
        if isCorrect{
            img = UIImage(systemName: "checkmark") ?? UIImage()
            color = .green
        }
        else{
            img = UIImage(systemName: "xmark") ?? UIImage()
            color = .red
        }
        return (correctWords[index],userTypedWords[index],img,color)
    }
    
    func evaluateAnswer(_ userTypedWord: String,_ wordToType: String) -> Bool{
        correctWords.append(wordToType)
        userTypedWords.append(userTypedWord)
        return userTypedWord == wordToType
    }
    
    func reset(){
        correctWords.removeAll()
        userTypedWords.removeAll()
        tableView = nil
    }
    
}
