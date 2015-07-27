//
//  DAOAuxiliar.swift
//  Memories
//
//  Created by Juliana Zilberberg on 7/27/15.
//  Copyright (c) 2015 Juliana Zilberberg. All rights reserved.
//

import Foundation





class DAOAuxiliar {
    
    
    
    
    
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