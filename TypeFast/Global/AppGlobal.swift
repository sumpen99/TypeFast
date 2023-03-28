//
//  AppGlobal.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-26.
//

import UIKit

var APP_SCREEN_DIMENSIONS : CGSize {
    return UIScreen.main.bounds.size
}

func printAny(_ any:Any){
    print("\(any)")
}

func getCurrentDate() -> String{
    let date = Date()
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd HH:mm:ss"
    return df.string(from: date)
}

func getCorrectOrderOfControllers() -> [String]{
    printAny("hepp")
    switch APP_PLAYER.level {
        case "Easy" :
            return ["Easy","Medium","Hard","Expert"]
        case "Medium" :
            return ["Medium","Hard","Expert","Easy"]
        case "Hard" :
            return ["Hard","Expert","Easy","Medium"]
        default :
            return ["Expert","Easy","Medium","Hard"]
    }
}

let TOTAL_GAME_TIME = 15
let TOTAL_ANSWER_TIME = 7.0
let WORDS_BUFFER = 100
let MAX_HIGHSCORE_PLAYERS = 10

let GAME_LEVELS = ["Easy","Medium","Hard","Expert"]

let APP_PLAYER = Player()

func clearAllTestData(){
    for level in GAME_LEVELS{
        SharedPreference.removePlayersFromTable(level)
    }
}

func populateHighScoreWithTestData(){
    let players = [
    HighScorePlayer(name: "Fredrik", date: getCurrentDate(), points: 10),
    HighScorePlayer(name: "Johan", date: getCurrentDate(), points: 11),
    HighScorePlayer(name: "Daniel", date: getCurrentDate(), points: 12),
    HighScorePlayer(name: "Erik", date: getCurrentDate(), points: 9),
    HighScorePlayer(name: "Johanna", date: getCurrentDate(), points: 20),
    HighScorePlayer(name: "Kristoffer", date: getCurrentDate(), points: 1),
    HighScorePlayer(name: "Sara", date: getCurrentDate(), points: 2),
    HighScorePlayer(name: "Erica", date: getCurrentDate(), points: 15),
    HighScorePlayer(name: "Kristin", date: getCurrentDate(), points: 4),
    HighScorePlayer(name: "Sofie", date: getCurrentDate(), points: 3),]
    
    for level in GAME_LEVELS{
        for player in players{
            let name = player.name
            player.name += " ( \(level) )"
            SharedPreference.writeNewPlayerToTable(level, player: player)
            player.name = name
        }
    }
}
