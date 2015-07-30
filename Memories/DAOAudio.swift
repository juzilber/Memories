//
//  DAOAudio.swift
//  Memories
//
//  Created by Mayara Gasparini Dias  on 27/07/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import Foundation

class DAOAudio: NSObject {
    
<<<<<<< HEAD
<<<<<<< HEAD
    class func createAudioGame(gameTitle: String) {
=======
    class func createAudio(gameTitle: String) {
>>>>>>> origin/master
=======
    class func createAudio(gameTitle: String) {
>>>>>>> origin/master
        let rootPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        
        //funcao para load plist
        let path : String = getPlistPath(rootPath)
        
        //abrir o arquivo e carregar a plist
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
=======
>>>>>>> origin/master
        var audioArray : NSMutableArray! = NSMutableArray(contentsOfFile: path)
        
        //chave identificadora do audio
        var audioName : String = ""
        if audioArray == nil {
            audioArray = NSMutableArray()
            println("adad")
        }
        if audioArray.count == 0 {
            audioName = "0.caf"
        }
        var audioDict : NSMutableDictionary = NSMutableDictionary()
        audioDict.setValue(gameTitle, forKey: "AudioTitle")
        if audioName == "" {
            let count : Int = audioArray.count
            let lastAudioDict : NSMutableDictionary = audioArray[count-1] as! NSMutableDictionary
            let lastNumber : NSNumber = (lastAudioDict.valueForKey("index") as! NSNumber)
            let index : Int = lastNumber.integerValue + 1
            audioName = "\(index).caf"
            audioDict.setValue(audioName, forKey: "audioName")
            audioDict.setValue(index, forKey: "index")
        }
        else {
            audioDict.setValue(audioName, forKey: "audioName")
            audioDict.setValue(NSNumber(integer: 0), forKey: "index")
        }
        audioArray.addObject(audioDict)
        audioArray.writeToFile(path, atomically: false)
<<<<<<< HEAD
>>>>>>> origin/master
=======
>>>>>>> origin/master
        let fileManager = NSFileManager.defaultManager()
        fileManager.copyItemAtPath(rootPath.stringByAppendingPathComponent("temp.caf"), toPath: rootPath.stringByAppendingPathComponent(audioName), error: nil)
        println(audioName)
    }
    
    /**************************************************************************/
    
    class func deleteAudio(index: Int) {
        var rootPath:NSString = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! NSString
        var path:NSString = rootPath.stringByAppendingPathComponent("DaoAudio.plist")
        var fileManager = NSFileManager.defaultManager()
<<<<<<< HEAD
<<<<<<< HEAD
=======
        
>>>>>>> origin/master
=======
        
>>>>>>> origin/master
        // Se o arquivo nao existir
        if (!fileManager.fileExistsAtPath(path as String)) {
            var sourcePath: String = NSBundle.mainBundle().pathForResource("DaoAudio", ofType: "plist")!;
            fileManager.copyItemAtPath(sourcePath, toPath: path as String, error: nil)
        }
<<<<<<< HEAD
<<<<<<< HEAD
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
=======
=======
>>>>>>> origin/master
        var audioArray : NSMutableArray! = NSMutableArray(contentsOfFile: path as String)
        let audioDict : NSDictionary = audioArray[index] as! NSDictionary
        let audioName : String = audioDict.valueForKey("audioName") as! String
        fileManager.removeItemAtPath(rootPath.stringByAppendingPathComponent(audioName), error:nil)
        audioArray.removeObjectAtIndex(index)
        audioArray?.writeToFile(path as String, atomically: false)
    }
    
    /************************************************************************/
    
    //funcao q pega da plist e salva
    class func getAllAudio() -> [DAOAudio] {
        var rootPath: String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String
        let path : String = getPlistPath(rootPath)
        var audioArray : NSMutableArray! = NSMutableArray(contentsOfFile: path)
        var audioDict : NSMutableDictionary = NSMutableDictionary()
        if audioArray == nil || audioArray.count == 0 {
            return []
        }
        var audios : [DAOAudio] = []
        for var i = 0 ; i < audioArray.count; i++ {
            let dict : NSDictionary = audioArray[i] as! NSDictionary
            var audioName : String = dict.valueForKey("audioName") as! String
            audios.append(DAOAudio())
            //antes: DAOAudio(title, audioName: audioName))
        }
        return audios
<<<<<<< HEAD
>>>>>>> origin/master
=======
>>>>>>> origin/master
    }
    
    //Funcao para pegar a plist
    private class func getPlistPath(rootPath: String) -> String {
        var path: String = rootPath.stringByAppendingPathComponent("DaoAudio.plist")
        var fileManager = NSFileManager.defaultManager()
<<<<<<< HEAD
<<<<<<< HEAD
=======
        
>>>>>>> origin/master
=======
        
>>>>>>> origin/master
        // Se o arquivo nao existir
        if (!fileManager.fileExistsAtPath(path)) {
            var sourcePath: String = NSBundle.mainBundle().pathForResource("DaoAudio", ofType: "plist")!;
            fileManager.copyItemAtPath(sourcePath, toPath: path, error: nil)
        }
        return path
    }
    // fecha classe
}