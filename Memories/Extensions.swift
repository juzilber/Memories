//
//  Extensions.swift
//  Memories
//
//  Created by Pietro Ribeiro Pepe on 10/10/15.
//  Copyright © 2015 Juliana Zilberberg. All rights reserved.
//

import Foundation

extension String{
    
    func stringByAppendingPathComponent(path: String) -> String{
        return self + "/" + path;
    }
    
}