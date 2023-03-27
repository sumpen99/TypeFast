//
//  SharedPreference.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-27.
//

import Foundation

class SharedPreference {
    
    static let userDefault = UserDefaults.standard
   
    static func writeData(key: String,value: Any){
        userDefault.setValue(value, forKey: key)
        userDefault.synchronize()
    }
    
    static func getIntValue(key : String) -> Int{
        return userDefault.object(forKey: key) == nil ? 0 : userDefault.integer(forKey: key)
    }
    
    static func getStringValue(key : String) -> String{
        return userDefault.object(forKey: key) == nil ? "" : userDefault.string(forKey: key)!
    }
    
    static func getBoolValue(key : String) -> Bool{
        return userDefault.object(forKey: key) == nil ? false : userDefault.bool(forKey: key)
    }
    
}
