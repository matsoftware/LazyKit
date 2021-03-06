//
//  LazyStyleSheet.swift
//  LazyKit
//
//  Created by Malkic Kevin on 20/04/2015.
//  Copyright (c) 2015 Malkic Kevin. All rights reserved.
//

import Foundation
import UIKit

internal enum LazyStyleSheetParserType : Int {
    
    case JSON
    case CSS
}

internal class LazyStyleSheet: NSObject, LazyStyleSheetParserDelegate {
    
    var styleSets = [LazyStyleSet]()
    
    var bodyStyle: LazyStyleSet?
    
    func startParsingFileAtUrl(url: NSURL, parserType: LazyStyleSheetParserType) -> Bool {
        
        let parser: LazyStyleSheetParser?
        
        switch parserType {
            
        case .CSS:
            parser = LazyStyleSheetCSSParser()
            
        default:
            parser = nil
        }
        
        if parser == nil {
            
            return false
        }
        
        parser!.parseData(NSData(contentsOfURL: url), delegate: self)
        
        return true
    }
    
    func styleThatMatchView(view: UIView, styleId: String?, styleClass: String?) -> LazyStyleSet? {
        
        var newStyleSet: LazyStyleSet? = bodyStyle ?? LazyStyleSet()
        
        let possibilities = possibilityPatterns(view.dynamicType, styleClass: styleClass, styleId: styleId)
        
        let styleSetsTmp = styleSets
        
        for styleSet in styleSetsTmp {
            
            if testPatterns(patterns: styleSet.patterns, possibilities: possibilities) {
                
                newStyleSet = newStyleSet + styleSet
                
            }
        }
        
        return newStyleSet
    }
    
    func possibilityPatterns(klass:AnyClass, styleClass: String?, styleId: String?) -> [String] {
        
        var possibilities = [String]()
        
        let klassName = NSStringFromClass(klass)

        possibilities.append(klassName)
        
        if styleClass != nil {
            
            let klasses = styleClass!.componentsSeparatedByString(" ")
            
            for klass in klasses {
                
                possibilities.append( klassName + String(format:".%@",klass) )
                possibilities.append( String(format:".%@",klass) )
                
                if styleId != nil {
                    
                    possibilities.append( klassName + String(format:"#%@",styleId!) )
                    possibilities.append( String(format:"#%@",styleId!) )
                }
                
                if styleId != nil && styleClass != nil {
                    
                    possibilities.append( klassName + String(format:"#%@.%@",styleId!,klass) )
                    possibilities.append( String(format:"#%@.%@",styleId!,klass) )
                }
            }
            
        } else if styleId != nil {
			
			possibilities.append( klassName + String(format:"#%@",styleId!) )
			possibilities.append( String(format:"#%@",styleId!) )
        }
		
        return possibilities
    }
    
    func testPatterns(patterns patterns: [String], possibilities: [String]) -> Bool {
    
        for pattern in patterns {
            
            if possibilities.contains(pattern) {
                
                return true
            }
        }
        
        return false
    }
    
    //MARK - LazyStyleSheetParserDelegate
    
    func didFinishParsing(parser: LazyStyleSheetParser, styleSets: [LazyStyleSet]!) {
        
        self.styleSets += styleSets
        
        let searchResults = styleSets.filter() {
            
            for pattern in $0.patterns {
                
                if pattern == "body" {
                    
                    return true
                }
            }
            return false
        }
        
        if searchResults.count > 0 {
            
            bodyStyle = LazyStyleSet()
            
            for style in searchResults {
                
                bodyStyle = bodyStyle + style
            }
        }
    }
    
    func didFailParsing(parser: LazyStyleSheetParser, error: NSError) {
        
    }
}
