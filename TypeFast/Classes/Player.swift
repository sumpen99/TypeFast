//
//  Player.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

class Player{
    var name: String = ""
    var level: String = ""
    var points: Int = 0
    var numTypedWords: Int = 0
    
    func evaluateAnswer(_ playerAnswer: String,wordToType: String){
        if playerAnswer == wordToType {
            points += 1
        }
        else{
            let points = max(0,points-1)
            self.points = points
        }
        numTypedWords += 1
    }
    
    func getCurrentScore() -> String{
        return "\(points)/\(numTypedWords)"
    }
    
    func resetPlayer(){
        points = 0
        numTypedWords = 0
    }
    
    deinit{
        printAny("deinit player")
    }
}
