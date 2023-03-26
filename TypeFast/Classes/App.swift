//
//  App.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-26.
//

class App{
    
    static let shared = App()
    
    private var player: Player
    private var wordModel: WordModel
    private var gameModel: GameModel
    
    init(){
        printAny("init app")
        player = Player()
        wordModel = WordModel()
        gameModel = GameModel()
    }
    
    static func clearWordModel(){
        shared.wordModel.clearWordList()
    }
    
    static func loadNewWords(){
        shared.wordModel.loadWords()
    }
    
    static func setPlayerLevel(_ level: String){
        shared.player.level = level
    }
    
    static func updateScore(userTypedWord: String, wordToType: String){
        let result = shared.gameModel.evaluateAnswer(userTypedWord,wordToType)
        shared.player.updateScore(result)
    }
    
    static func getCurrentScore() -> String {
        return shared.player.getCurrentScore()
    }
    
    
}
