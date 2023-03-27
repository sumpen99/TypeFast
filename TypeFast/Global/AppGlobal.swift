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

let TOTAL_GAME_TIME = 10
let TOTAL_ANSWER_TIME = 7.0
let WORDS_BUFFER = 100

let GAME_LEVELS = ["Easy","Medium","Hard","Expert"]

let APP_PLAYER = Player()
