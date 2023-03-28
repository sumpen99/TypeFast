//
//  HighScorePlayer.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-27.
//
import Foundation

class HighScorePlayer: NSObject, NSCoding ,NSSecureCoding{
    static var supportsSecureCoding: Bool { return true}
    
    var name: String
    var date: String
    var points: Int32


    init(name: String?,date:String?,points:Int32?) {
        self.name = name ?? ""
        self.date = date ?? ""
        self.points = points ?? 0

    }
    
    convenience init(date:String) {
        self.init(name:APP_PLAYER.name,date:date,points:Int32(APP_PLAYER.points))
    }

    required convenience init(coder aDecoder: NSCoder) {
        let name = aDecoder.decodeObject(forKey: "name") as? String
        let date = aDecoder.decodeObject(forKey: "date") as? String
        let points = aDecoder.decodeInt32(forKey: "points")
        self.init(name:name,date:date,points:points)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(points, forKey: "points")
    }
}
