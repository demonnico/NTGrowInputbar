//
//  NTInputbar.swift
//  NTInputbar
//
//  Created by Nicholas Tau on 3/28/16.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

//static const float kButtonHeight = 30;
//static const float kButtonWidth = 30;
//static const float kMarginBetweenWidgets    = 5;
//static const float kMarginTextFieldBottom   = 5;
//static const float kMarginTextFieldTop      = kMarginTextFieldBottom;
//
//static const float kToolBarMaxHeight = 100;
//static const float kToolBarMinHeight = 50;
class NTInputbar: UIView {
    
    let kMarginBetweenWidgets :CGFloat = 5.0
    let kMarginTextViewBottom :CGFloat = 5.0
    let kMarginTextViewTop :CGFloat = 5.0
    let kToolbarMaxHeight :CGFloat = 100.0
    let kToolbarMinHeight :CGFloat = 50.0
    
    var buttonLeft: NTResponseButton?{
        willSet{
            buttonLeft?.removeFromSuperview()
        }
        didSet{
            self.addSubview(buttonLeft!)
            self.setNeedsLayout()
        }
    }
    var buttonRight: NTResponseButton?{
        willSet{
            buttonRight?.removeFromSuperview()
        }
        didSet{
            self.addSubview(buttonRight!)
            self.setNeedsLayout()
        }
    }
    let textView = NTAtTextView.init(frame: CGRectZero, textContainer: nil)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commitInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commitInit()
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func commitInit() {
        layer.borderWidth = 0.5;
        layer.borderColor = UIColor.init(red: 217/255.0, green: 207/255.0, blue: 255.0, alpha: 1.0).CGColor
        layer.backgroundColor = UIColor.init(white: 248/255.0, alpha: 1.0).CGColor
        
        self.addSubview(textView)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(textViewTextChanged),
                                                         name: UITextViewTextDidChangeNotification,
                                                         object: self.textView)
    }
    
    func textViewTextChanged(notification :NSNotification)  {
        if let object = notification.object {
            if object as! UITextView == textView {
                self.setNeedsLayout()
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let sizeThatFits = textView.sizeThatFits(textView.frame.size)
        var newHeight = sizeThatFits.height + kMarginTextViewTop + kMarginTextViewBottom
        newHeight = min(newHeight, kToolbarMaxHeight)
        newHeight = max(newHeight, kToolbarMinHeight)
        frame.size.height = CGFloat(newHeight)
        
        buttonLeft?.frame.origin.y = frame.height-(buttonLeft?.frame.size.height)!
        buttonRight?.frame.origin.y = (buttonLeft?.frame.origin.y)!
        
        buttonLeft?.frame.origin.x = kMarginBetweenWidgets
        buttonRight?.frame.origin.x = frame.size.width - (buttonRight?.frame.size.width)! - kMarginBetweenWidgets
        
        var textViewX = kMarginBetweenWidgets
        let textViewY = kMarginTextViewTop
        var textViewWidth = frame.size.width - kMarginBetweenWidgets - kMarginBetweenWidgets
        let textViewHeight = frame.size.height - kMarginTextViewTop - kMarginTextViewBottom
        if let leftOne = buttonLeft {
            textViewX = leftOne.frame.maxX+kMarginBetweenWidgets
            textViewWidth = textViewWidth - leftOne.frame.size.width - kMarginBetweenWidgets
        }
        if let rightOne = buttonRight {
            textViewWidth = textViewWidth - rightOne.frame.size.width - kMarginBetweenWidgets
        }
        
        textView.frame = CGRectMake(textViewX, textViewY, textViewWidth, textViewHeight)
    }
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    

}
