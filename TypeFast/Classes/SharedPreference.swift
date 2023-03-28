//
//  SharedPreference.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-27.
//

import Foundation

class SharedPreference {
    
    static let userDefault = UserDefaults.standard
    
    static func writeNewPlayerIfScoreMadeBoard(completion: ((Bool) -> Void)){
        let level = APP_PLAYER.level
        let player = HighScorePlayer(date: getCurrentDate())
        guard var table = SharedPreference.getPlayersFromTable(level) else {
            writeNewPlayersToTable(level, players: [player])
            completion(true)
            return
        }
        
        let cnt = table.count
        if cnt >= MAX_HIGHSCORE_PLAYERS && player.points < table[cnt-1].points { completion(false);return;}
        table.append(player)
        table = table.sorted{ $0.points > $1.points }
        if cnt+1 > MAX_HIGHSCORE_PLAYERS { table.removeLast()}
        writeNewPlayersToTable(level,players: table)
        completion(true)
    }
    
    static func writeNewPlayerToTable(_ level: String,player: HighScorePlayer){
        guard let table = SharedPreference.getPlayersFromTable(level) else {
            writeNewPlayersToTable(level, players: [player])
            return
        }
      
        sortAndInsert(table: table,player: player){ newTable in
            writeNewPlayersToTable(level,players: newTable)
        }
        
        
    }
    
    private static func writeNewPlayersToTable(_ level: String,players: [HighScorePlayer]){
        do{
            let encodedData: Data = try NSKeyedArchiver.archivedData(
                withRootObject: players,
                requiringSecureCoding: false)
            userDefault.set(encodedData, forKey: level)
        }
        catch{
            printAny(error)
        }
    }
    
    static func getPlayersFromTable(_ level: String) -> [HighScorePlayer]? {
        guard let decodedData = userDefault.data(forKey: level) else { return nil }
        do{
            let decodedPlayers = try (NSKeyedUnarchiver.unarchivedObject(
                ofClasses: [NSArray.self, NSString.self, NSNumber.self, HighScorePlayer.self], from: decodedData) as? [HighScorePlayer])
            return decodedPlayers
            
        }
        catch{
            printAny(error)
        }
        return nil
    }
    
    static func getLastPlayerFromTable(_ level: String) -> Int32 {
        guard let decodedData = userDefault.data(forKey: level) else { return -1 }
        do{
            let decodedPlayers = try (NSKeyedUnarchiver.unarchivedObject(
                ofClasses: [NSArray.self, NSString.self, NSNumber.self, HighScorePlayer.self], from: decodedData) as? [HighScorePlayer])
            return decodedPlayers?.last?.points ?? -1
            
        }
        catch{
            printAny(error)
        }
        return -1
    }
    
    static func removePlayersFromTable(_ level:String){
        UserDefaults.standard.removeObject(forKey: level)
    }
    
    private static func sortAndInsert(table: [HighScorePlayer],
                                      player: HighScorePlayer,
                                      completion: (([HighScorePlayer]) -> Void)? = nil){
        var sortedTable = table.sorted{ $0.points < $1.points }
        
        let index = max(0,sortedTable.firstIndex(where: { $0.points >= player.points }) ??  -1)
        sortedTable.insert(player,at: index)
        sortedTable = sortedTable.sorted{ $0.points > $1.points }
        completion?(sortedTable)
    }
    
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
