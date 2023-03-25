//
//  FileHandler.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

/*guard let file = freopen(wordPath,"r",stdin) else { return }
defer{
    fclose(file)
}

while let line = readLine(){
    printAny(line)
}*/

import Foundation

class FileHandler{
    
    static func readFile(_ level:String,completion: (([String]) -> Void)? = nil){
        guard let wordPath = Bundle.main.path(forResource: "words\(level)", ofType: "txt") else{ return }
        let contents = try! String(contentsOfFile: wordPath)
        let lines = contents.components(separatedBy: "\n")
        let shuffledWords = lines.shuffled()
        let maxWords = min(shuffledWords.count,2)
        let randomWords = Array(shuffledWords.prefix(maxWords))
        completion?(randomWords)
        /*DispatchQueue.global().async {
            let contents = try! String(contentsOfFile: wordPath)
            let lines = contents.components(separatedBy: "\n")
            let shuffledWords = lines.shuffled()
            let maxWords = min(shuffledWords.count,500)
            let randomWords = Array(shuffledWords.prefix(maxWords))
            DispatchQueue.main.sync {
                completion?(randomWords)
            }
        }*/
    }
}
