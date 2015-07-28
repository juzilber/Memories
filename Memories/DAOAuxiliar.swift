//
//  DAOAuxiliar.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/27/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import Foundation


class DAOAuxiliar {

    
    class func checkFiles(filename: String, type: String){
        
        var contents : NSMutableDictionary!;
        
        let familyPath : String;
        
        let familyPathDoc : String;

        
        var documentPath : String = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as! String;
        var imgPath:String = documentPath
        familyPathDoc = documentPath.stringByAppendingPathComponent("Family")
        
        familyPath = documentPath.stringByAppendingPathComponent("Family/FamilyData.plist");
        
        println(familyPath)
        var fileManager:NSFileManager = NSFileManager.defaultManager();
        
        if(!fileManager.fileExistsAtPath(documentPath)){
            let sourcePath:String = NSBundle.mainBundle().pathForResource(filename, ofType: type)!;
            fileManager.copyItemAtPath(sourcePath, toPath: documentPath, error: nil);
        }
        
        
        var imgPessPath = imgPath.stringByAppendingPathComponent("imgProf");
        
        fileManager.createDirectoryAtPath(imgPessPath, withIntermediateDirectories:false, attributes:nil, error:nil);
    }
    
    func getFreeIdInDict(dict:NSDictionary) -> String{
        
        
        
        var id : Int = 0;
        
        var idArray : NSArray = dict.allKeys;
        
        for(id = 0 ; idArray.containsObject(String(id)); id++){
            
        };
        
        
        
        return String(id);
        
    }
    
    
    func loadPList() -> NSMutableDictionary?{
        
        return nil;
        
    }
    
}