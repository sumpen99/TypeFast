//
//  WordModel.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

class WordModel{
    var wordList = [String]()
    var count = 0
    var level: String = ""
    
    init(level: String){
        self.level = level
    }
    
    func loadWords(){
        FileHandler.readFile(level){ words in
            self.wordList = words
        }
    }
    
    func getNextWord() -> String {
        var word = ""
        if(count < wordList.count){
            word = wordList[count]
            count += 1
        }
        else{
            reset()
            return getNextWord()
        }
        return word
    }
    
    func reset(){
        count = 0
        loadWords()
    }
    
    deinit{
        printAny("deinit wordmodel")
    }
}
