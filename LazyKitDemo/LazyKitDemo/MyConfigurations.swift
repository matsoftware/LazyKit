//
//  MyConfigurations.swift
//  LazyKitDemo
//
//  Created by Kevin Malkic on 16/01/2016.
//  Copyright © 2016 Kevin Malkic. All rights reserved.
//

import UIKit
import LazyKit

struct MyConfigurations: LazyViewConfigurations {
    
    static func elementsOptions() -> [ElementOptions]? {
        
        return [
            LabelOptions(identifier: "title",
                classType: CustomLabel.self,
                viewBaseOptions: ViewBaseOptions(backgroundColor: .blueColor()),
                textOptions: TextBaseOptions(text: "hello", font: .systemFontOfSize(20), textAlignment: .Center)
            ),
            
            LabelOptions(identifier: "subtitle",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .greenColor()),
                textOptions: TextBaseOptions(text: "hey", textAlignment: .Center)
            ),
            
            ButtonOptions(identifier: "button",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .redColor()),
                textOptionsForType: [.Normal: TextBaseOptions(text: "button"), .Highlighted: TextBaseOptions(text: "highlighted")]
            ),
            
            ViewOptions(identifier: "line",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGrayColor())
            ),
            
            ImageOptions(identifier: "photo",
                viewBaseOptions: ViewBaseOptions(backgroundColor: .lightGrayColor()),
                imageBaseOptions: ImageBaseOptions(imageNamed: "image", contentMode: .ScaleAspectFill)
            ),
            
            TextFieldOptions(identifier: "textfield",
                viewBaseOptions: ViewBaseOptions(backgroundColor: UIColor.orangeColor()),
                textOptions: TextBaseOptions(font: .systemFontOfSize(16), textAlignment: .Center),
                placeholderOptions: TextBaseOptions(text: "placeholder", font: .systemFontOfSize(16), textColor: .redColor(), textAlignment: .Center),
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .Sentences, autocorrectionType: .No, spellCheckingType: .No, keyboardType: .NumbersAndPunctuation, keyboardAppearance: .Dark, returnKeyType: .Done, enablesReturnKeyAutomatically: true, secureTextEntry: false)
            ),
            
            TextViewOptions(identifier: "textview",
                viewBaseOptions: ViewBaseOptions(backgroundColor: UIColor.cyanColor()),
                textOptions: TextBaseOptions(text: "TextView", font: .systemFontOfSize(14), textAlignment: .Left),
                textInputOptions: TextInputBaseOptions(autocapitalizationType: .Sentences, autocorrectionType: .No, spellCheckingType: .No, keyboardType: .EmailAddress, keyboardAppearance: .Dark, returnKeyType: .Done, enablesReturnKeyAutomatically: true, secureTextEntry: false)
            )
        ]
    }
    
    static func visualFormatConstraintOptions() -> [VisualFormatConstraintOptions]? {
        
        return [
            VisualFormatConstraintOptions(string: "H:|-[photo(==photoW)]-[title]-|"),
            VisualFormatConstraintOptions(string: "H:[subtitle(==title)]"),
            VisualFormatConstraintOptions(string: "H:[textfield(==title)]"),
            VisualFormatConstraintOptions(string: "H:|-40-[line]-40-|"),
            VisualFormatConstraintOptions(string: "H:|-[textview]-|"),
            VisualFormatConstraintOptions(string: "H:|-buttonLeft-[button]-buttonRight-|"),
            VisualFormatConstraintOptions(string: "V:|-top-[title]-[subtitle]-[textfield]", options: .AlignAllLeft),
            VisualFormatConstraintOptions(string: "V:|-top-[photo(==photoH)]"),
            VisualFormatConstraintOptions(string: "V:[line(==1)]-[textview(==200)]-200-[button(==buttonH)]-8-|")
        ]
    }
    
    static func visualFormatMetrics() -> [String: AnyObject]? {
        
        return ["top" : 30, "buttonH" : 44, "buttonLeft" : 100, "buttonRight" : 100, "photoW" : 100, "photoH" : 60]
    }
    
    static func layoutConstraints() -> [ConstraintOptions]? {
        
        return [
            ConstraintOptions(identifier: "titleHeight", itemIdentifier: "title", attribute: .Height, relatedBy: .Equal, toItemIdentifier: nil, attribute: .Height, multiplier: 1, constant: 40)
        ]
    }
}
