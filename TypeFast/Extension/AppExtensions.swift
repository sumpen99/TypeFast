//
//  AppExtensions.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-21.
//
import UIKit

var APP_SCREEN_DIMENSIONS : CGSize {
    return UIScreen.main.bounds.size
}

func printAny(_ any:Any){
    print("\(any)")
}

func createButton(title:String) -> UIButton{
    let menuButton = UIButton(frame: CGRect(x:0,y:0,width:100,height:30))
    //menuButton.addTarget(self, action: #selector(tapFunction), for: .touchUpInside)
    menuButton.setTitle(title, for: .normal)
    menuButton.backgroundColor = .lightGray
    menuButton.layer.cornerRadius = 10
    return menuButton
}

let TOTAL_GAME_TIME = 10
let TOTAL_ANSWER_TIME = 10.0
