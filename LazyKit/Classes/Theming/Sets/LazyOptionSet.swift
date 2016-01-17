//
//  OptionSet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 22/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import UIKit

let kText_NumberOfLinesKey      = "text-maxline"

let kBar_TranslucentKey         = "translucent"


class LazyOptionSet {
   
    var numberOfLines: LazyInt?
    var translucent: LazyBool?
    
    init() {
        
    }
    
    init?(content: [String]!, variables: [String: String]?) {
        
        for property in content {
            
            let components = property.componentsSeparatedByString(":")
            if components.count != 2 {
                print("Invalid property should be 'key: value'\n")
                print(components)
                print("\n")
                return nil
            }
            
            let key = components[0].stringByReplacingOccurrencesOfString(" ", withString: "")
            let rawValue = components[1].stringByTrimmingCharactersInSet(.whitespaceCharacterSet()).stringByReplacingOccurrencesOfString(";", withString: "")
            
            var value = rawValue
            
            if variables != nil {
                if variables![rawValue] != nil {
                    value = variables![rawValue]!
                }
            }
            
            switch key {
                
            case kText_NumberOfLinesKey:
                numberOfLines = (value as NSString).integerValue
             
            case kBar_TranslucentKey:
                translucent = (value as NSString).boolValue
                
            default:
                break
            }
        }
        
        if isPropertiesNil() {
            return nil
        }
    }
    
    func isPropertiesNil() -> Bool {
        return numberOfLines == nil && translucent == nil
    }
}


func + (left:LazyOptionSet?, right:LazyOptionSet? ) -> LazyOptionSet? {
    
    if left == nil && right == nil { return nil }
    
    var object = LazyOptionSet()
    
    object.numberOfLines = left?.numberOfLines + right?.numberOfLines
    
    object.translucent = left?.translucent + right?.translucent
    
    return object
}