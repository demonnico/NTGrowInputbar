//
//  NTInputbar.swift
//  NTInputbar
//
//  Created by Nicholas Tau on 3/28/16.
//  Copyright © 2016 JJ. All rights reserved.
//

import UIKit

protocol InputbarAttachedScrollViewProtocol {
    func scrollToBottom()
}

class NTInputbar: UIView {
    
    let kMarginBetweenWidgets :CGFloat = 5.0
    let kMarginTextViewBottom :CGFloat = 5.0
    let kMarginTextViewTop :CGFloat = 5.0
    let textView = NTAtTextView.init(frame: CGRectZero, textContainer: nil)
    private var inputbarBottomHeight :CGFloat = 0.0
    var numberOfLines :Int = 4
    var inputbarHeightChanged :(CGFloat -> Void)?{
        didSet{
            
        }
    }
    var attachedScrollView :UIScrollView?
    var buttonLeft: NTResponseButton?{
        willSet{
            buttonLeft?.removeFromSuperview()
        }
        didSet{
            addSubview(buttonLeft!)
            setNeedsLayout()
        }
    }
    var buttonRight: NTResponseButton?{
        willSet{
            buttonRight?.removeFromSuperview()
        }
        didSet{
            addSubview(buttonRight!)
            setNeedsLayout()
        }
    }
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
        
        let accessoryView = BABFrameObservingInputAccessoryView.init(frame: CGRectZero)
        textView.inputAccessoryView = accessoryView
        accessoryView.inputAccessoryViewFramwChanged = {frame in
            self.inputbarBottomHeight = (self.superview?.frame.size.height)!-CGRectGetMinY(frame) - CGRectGetHeight((self.textView.inputAccessoryView?.frame)!)
            if self.inputbarHeightChanged != nil {
                self.inputbarHeightChanged!(self.frame.height + self.inputbarBottomHeight)
            }
        }
        addSubview(textView)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(textViewTextChanged),
                                                         name: UITextViewTextDidChangeNotification,
                                                         object: textView)
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
        
        textView.sizeToFit()
        //tool bar height
        var newHeight = textView.frame.height + kMarginTextViewTop + kMarginTextViewBottom
        
        let kContainerVerticalMargin = textView.textContainerInset.bottom + textView.textContainerInset.top + kMarginTextViewTop + kMarginTextViewBottom
        
        let kToolbarMaxHeight :CGFloat = (CGFloat(numberOfLines) * (textView.font?.lineHeight)!) +  kContainerVerticalMargin
        let kToolbarMinHeight :CGFloat = (CGFloat(1) * (textView.font?.lineHeight)!) + kContainerVerticalMargin
        
        newHeight = min(newHeight, kToolbarMaxHeight)
        newHeight = max(newHeight, kToolbarMinHeight)
        
        textView.scrollEnabled = newHeight == kToolbarMaxHeight
        
        var textViewX = kMarginBetweenWidgets
        let textViewY = kMarginTextViewTop
        var textViewWidth = frame.size.width - kMarginBetweenWidgets - kMarginBetweenWidgets
        if let leftOne = buttonLeft {
            leftOne.userInteractionEnabled = true
            textViewX = leftOne.frame.maxX+kMarginBetweenWidgets
            textViewWidth = textViewWidth - leftOne.frame.size.width - kMarginBetweenWidgets
            newHeight = max(newHeight, leftOne.frame.height + kMarginTextViewTop + kMarginTextViewBottom)
        }
        if let rightOne = buttonRight {
            rightOne.userInteractionEnabled = true
            textViewWidth = textViewWidth - rightOne.frame.size.width - kMarginBetweenWidgets
            newHeight = max(newHeight, rightOne.frame.height + kMarginTextViewTop + kMarginTextViewBottom)
        }
        
        let bottom = frame.maxY;
        frame.size.height = CGFloat(newHeight)
        //keep bottom on the same position
        frame.origin.y = bottom - newHeight;
        
        buttonLeft?.frame.origin.y = frame.height-(buttonLeft?.frame.size.height)!-kMarginTextViewBottom
        buttonRight?.frame.origin.y = frame.height-(buttonRight?.frame.size.height)!-kMarginTextViewBottom
        
        buttonLeft?.frame.origin.x = kMarginBetweenWidgets
        buttonRight?.frame.origin.x = frame.size.width - (buttonRight?.frame.size.width)! - kMarginBetweenWidgets
        
        textView.frame = CGRectMake(textViewX, textViewY, textViewWidth, newHeight - kMarginTextViewTop - kMarginTextViewBottom)
        
        if let s = textView.selectedTextRange {
            let rect = textView.caretRectForPosition(s.end)
            self.textView.scrollRectToVisible(rect, animated: false)
        }
        if inputbarHeightChanged != nil {
            inputbarHeightChanged!(CGFloat(newHeight+inputbarBottomHeight))
            attachedScrollView?.scrollToBottom()
        }
    }
}
