//
//  NTAtTextView.swift
//  NTInputbar
//
//  Created by Nicholas Tau on 3/28/16.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

class NTAtTextView: UITextView {
    
    //default placeholder color
    var placeHolderColor: UIColor? = UIColor.lightGrayColor()
    //default placeholder string
    var placeHolderString: String? = "text..."
    //if @ typed, event been trigger
    var atMentonTrigger: ((Void) -> (Void))!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer);
        commitInit()
    }
    
    deinit{
        
    }
    
    private func commitInit(){
        font = UIFont.systemFontOfSize(14)
        textColor = UIColor.blackColor()
        returnKeyType = .Send
        enablesReturnKeyAutomatically = true
        layer.borderColor = UIColor.blackColor().CGColor
        layer.borderWidth = 0.5
        layer.masksToBounds = true
        scrollEnabled = false
    }
    
    override func deleteBackward() {
        if self.text.hasSuffix("\0") && self.atMentonTrigger != nil {
            deleteModuleTrigger()
        }else{
            super.deleteBackward()
        }
        self.setNeedsDisplay()
    }
    
    override func insertText(text: String) {
        if text == "@" && self.atMentonTrigger != nil{
            self.atMentonTrigger();
        }else{
            super.insertText(text)
        }
        self.setNeedsDisplay()
    }
    
    
    func deleteModuleTrigger() {
        let textNS = self.text as NSString
        let range = textNS.rangeOfString("@",
                                         options:.BackwardsSearch,
                                         range:NSMakeRange(0, self.selectedRange.location))
        let selectIndex = self.selectedRange.location-2
        if range.location != NSNotFound {
            let prefix = self.text.characters.prefix(range.location)
            let suffix = self.text.characters.suffix(self.text.characters.count-self.selectedRange.location)
            self.text = (String.init(prefix)).stringByAppendingString(String.init(suffix))
            self.selectedRange = NSMakeRange(prefix.count, 0)
        }else if selectIndex >= 0 && selectIndex<textNS.length{
            self.text = textNS.substringToIndex(selectIndex) as String
        }
    }
    
    func insertMetionedMemberName(memberName: String) {
        self.text = self.text.stringByAppendingString(String.init(format:"@%@ \0", memberName))
    }
    
    private func metionModuleTrigger() {
        endEditing(true)
        if atMentonTrigger != nil {
            atMentonTrigger()
        }
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        super.drawRect(rect)
        if self.text.characters.count==0 && placeHolderString != nil{
            let drawString = NSString.init(string: placeHolderString!)
            drawString.drawInRect(CGRectInset(rect, 7.0, 5.0), withAttributes: placeHolderAttributes())
        }
    }
    
    private func placeHolderAttributes() -> [String: AnyObject]{
        let paragraphStyle = NSMutableParagraphStyle.init()
        paragraphStyle.lineBreakMode = .ByTruncatingTail
        paragraphStyle.alignment = textAlignment
        return [NSFontAttributeName:font!,
                NSForegroundColorAttributeName:placeHolderColor ?? self.textColor!,
                NSParagraphStyleAttributeName:paragraphStyle]
    }
}
