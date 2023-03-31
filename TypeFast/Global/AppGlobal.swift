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

let TOTAL_GAME_TIME = 60
let INFINITE_GAME_TIME = 999
let TOTAL_ANSWER_TIME = 10.0
let WORDS_BUFFER = 100
let MAX_HIGHSCORE_PLAYERS = 10

let USER_RESPONSE_TIME = "userResponseTime"
let GAME_LEVELS = ["Easy","Medium","Hard","Expert"]

let APP_PLAYER = Player()
