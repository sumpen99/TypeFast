//
//  HighScoreModel.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-27.
//

import Foundation

class HighScoreModel {
    
    static let userDefault = UserDefaults.standard
    
    static func writeNewPlayerToTable(_ level: String,player: HighScorePlayer){
        guard let table = HighScoreModel.getPlayersFromTable(level) else {
            writeNewPlayersToTable(level, players: [player])
            return
        }
        
        var sortedTable = table.sorted{ $0.points < $1.points }
        
        let index = max(0,sortedTable.firstIndex(where: { $0.points >= player.points }) ??  -1)
        sortedTable.insert(player,at: index)
        
        writeNewPlayersToTable(level,players: sortedTable)
    }
    
    static func writeNewPlayersToTable(_ level: String,players: [HighScorePlayer]){
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
            let decodedPlayers = try NSKeyedUnarchiver.unarchivedObject(
                ofClasses: [NSArray.self, NSString.self, NSNumber.self, HighScorePlayer.self], from: decodedData) as? [HighScorePlayer]
            return decodedPlayers
            
        }
        catch{
            printAny(error)
        }
        return nil
    }
    
    static func removePlayersFromTable(_ level:String){
        UserDefaults.standard.removeObject(forKey: level)
    }
    
}
