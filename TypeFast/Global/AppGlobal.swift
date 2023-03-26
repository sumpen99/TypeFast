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

let TOTAL_GAME_TIME = 10
let TOTAL_ANSWER_TIME = 10.0
let WORDS_BUFFER = 100

let APP_PLAYER = Player()
