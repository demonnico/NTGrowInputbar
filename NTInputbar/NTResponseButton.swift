//
//  NTResponseButton.swift
//  NTInputbar
//
//  Created by Nicholas Tau on 3/29/16.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

//#http://stackoverflow.com/questions/26083377/swift-setting-an-optional-property-of-a-protocol
//workaround here
@objc protocol NTTextInputTraits : UITextInputTraits{
    var returnKeyType: UIReturnKeyType{get set}
    var enablesReturnKeyAutomatically: Bool{get set}
}

class NTResponseButton: UIButton, UIKeyInput, NTTextInputTraits {
    
    var realTurnKeyType: UIReturnKeyType! = .Send
    var realEnablesReturnKeyAutomatically: Bool = true
    
    var returnKeyType: UIReturnKeyType{
        get{
            return realTurnKeyType ?? .Done
        }set{
            self.returnKeyType = newValue;
        }
    }
    
    var enablesReturnKeyAutomatically: Bool{
        get{
            return realEnablesReturnKeyAutomatically ?? false
        }set{
            self.realEnablesReturnKeyAutomatically = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func commitInit() {
        
    }
    
    func hasText() -> Bool {
        return false
    }
    
    func deleteBackward() {
        
    }
    
    func insertText(text: String) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
