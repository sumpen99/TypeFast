//
//  Player.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

class Player{
    var name: String = ""
    var level: String = "Easy"
    var gameMode: String = ""
    var points: Int = 0
    var numTypedWords: Int = 0
    
    func setNewName(_ name: String?) -> Bool{
        guard let name = name else { return false }
        if name.isEmpty { return false }
        self.name = name
        return true
    }
    
    func updateScore(_ answerIsCorrect: Bool){
        /*if answerIsCorrect {
            points += 1
        }
        else{
            let points = max(0,points-1)
            self.points = points
        }*/
        points += answerIsCorrect ? 1 : 0
        numTypedWords += 1
    }
    
    func getCurrentScore() -> String{
        return "\(points)/\(numTypedWords)"
    }
    
    func getCurrentScore() -> Double{
        if numTypedWords == 0 { return 0.0 }
        return Double(points)/Double(numTypedWords)
    }
    
    func resetPlayer(){
        points = 0
        numTypedWords = 0
    }
    
    deinit{
        printAny("deinit player")
    }
}
