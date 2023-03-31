//
//  WordModel.swift
//  TypeFast
//
//  Created by fredrik sundström on 2023-03-25.
//

class WordModel{
    var wordList = [String]()
    var count = 0
    var currentWord: String = ""
    
    func loadWords(){
        FileHandler.readFile(APP_PLAYER.level){ words in
            self.wordList = words
        }
    }
    
    func clearWordList(){
        wordList.removeAll()
    }
    
    func getNextWord() -> String {
        if(count < wordList.count){
            currentWord = wordList[count]
            count += 1
        }
        else{
            reset()
            return getNextWord()
        }
        return currentWord
    }
    
    func reset(){
        count = 0
        loadWords()
    }
  
}
