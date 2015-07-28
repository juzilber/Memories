//
//  DAOAudio.swift
//  Memories
//
//  Created by Mayara Gasparini Dias  on 27/07/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import Foundation

class DAOAudio: NSObject {
    
    class func createAudioGame(gameTitle: String) {
        let rootPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        //funcao para load plist
        let path : String = getPlistPath(rootPath)
        
        //abrir o arquivo e carregar a plist
        var audioGameArray : NSMutableArray! = NSMutableArray(contentsOfFile: path)
        
        //chave identificadora do audio
        var audioName : String = ""
        if audioGameArray == nil {
            audioGameArray = NSMutableArray()
            println("adad")
        }
        if audioGameArray.count == 0 {
            audioName = "0.caf"
        }
        var audioGameDict : NSMutableDictionary = NSMutableDictionary()
        audioGameDict.setValue(gameTitle, forKey: "gameAudioTitle")
        if audioName == "" {
            let count : Int = audioGameArray.count
            let lastAudioGameDict : NSMutableDictionary = audioGameArray[count-1] as! NSMutableDictionary
            let lastNumber : NSNumber = (lastAudioGameDict.valueForKey("index") as! NSNumber)
            let index : Int = lastNumber.integerValue + 1
            audioName = "\(index).caf"
            audioGameDict.setValue(audioName, forKey: "audioName")
            audioGameDict.setValue(index, forKey: "index")
        }
        else {
            audioGameDict.setValue(audioName, forKey: "audioName")
            audioGameDict.setValue(NSNumber(integer: 0), forKey: "index")
        }
        audioGameArray.addObject(audioGameDict)
        audioGameArray.writeToFile(path, atomically: false)
        let fileManager = NSFileManager.defaultManager()
        fileManager.copyItemAtPath(rootPath.stringByAppendingPathComponent("temp.caf"), toPath: rootPath.stringByAppendingPathComponent(audioName), error: nil)
        println(audioName)
    }
    
    /**************************************************************************/
    
    class func deleteAudio(index: Int) {
        var rootPath:NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        var path:NSString = rootPath.stringByAppendingPathComponent("DaoAudio.plist")
        var fileManager = NSFileManager.defaultManager()
        // Se o arquivo nao existir
        if (!fileManager.fileExistsAtPath(path as String)) {
            var sourcePath: String = NSBundle.mainBundle().pathForResource("DaoAudio", ofType: "plist")!;
            fileManager.copyItemAtPath(sourcePath, toPath: path as String, error: nil)
        }
        var audioGameArray : NSMutableArray! = NSMutableArray(contentsOfFile: path as String)
        let audioGameDict : NSDictionary = audioGameArray[index] as! NSDictionary
        let audioName : String = audioGameDict.valueForKey("audioName") as! String
        fileManager.removeItemAtPath(rootPath.stringByAppendingPathComponent(audioName), error:nil)
        audioGameArray.removeObjectAtIndex(index)
        audioGameArray?.writeToFile(path as String, atomically: false)
    }
    
    /************************************************************************/
    class func getAllAudioGames() -> [DAOAudio] {
        var rootPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let path : String = getPlistPath(rootPath)
        var audioGameArray : NSMutableArray! = NSMutableArray(contentsOfFile: path)
        var audioGameDict : NSMutableDictionary = NSMutableDictionary()
        if audioGameArray == nil || audioGameArray.count == 0 {
            return []
        }
        var audioGames : [DAOAudio] = []
        for var i = 0 ; i < audioGameArray.count; i++ {
            let dict : NSDictionary = audioGameArray[i] as! NSDictionary
            var title : String = dict.valueForKey("gameAudioTitle") as! String
            var audioName : String = dict.valueForKey("audioName") as! String
            audioGames.append(DAOAudio())
            //antes: DAOAudio(title, audioName: audioName))
        }
        return audioGames
    }
    
    //Funcao para pegar a plist
    private class func getPlistPath(rootPath: String) -> String {
        var path: String = rootPath.stringByAppendingPathComponent("DaoAudio.plist")
        var fileManager = NSFileManager.defaultManager()
        // Se o arquivo nao existir
        if (!fileManager.fileExistsAtPath(path)) {
            var sourcePath: String = NSBundle.mainBundle().pathForResource("DaoAudio", ofType: "plist")!;
            fileManager.copyItemAtPath(sourcePath, toPath: path, error: nil)
        }
        return path
    }
    // fecha classe
}